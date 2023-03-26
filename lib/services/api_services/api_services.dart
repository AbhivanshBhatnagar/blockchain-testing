import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/services/api_services/api_client/avex_api_client.dart';
import 'package:test_project/services/api_services/api_response.dart';
import 'package:test_project/services/local_services/encrypted_shared_pref.dart';

import '../../models/models.dart';
import '../../models/responses/get_existence_response.dart';
import '../dio_provider.dart';

final apiServiceProvider = Provider<ApiService>((ref) =>
    ApiService(ref.read(dioProvider), ref.read(encryptedSharedPrefProvider)));

class ApiService {
  late final AvexApiClient avexApiClient;
  late final EncryptedSharedPref sharedPref;
  final String unknownErrorMessage = "An Unknown Error Message Happen";

  Future<ApiResponse<void>> signupWithDynamicLink(String email) async {
    final request = SignupRequest(email: email);
    final response = await avexApiClient.generateEmailDynamicLink(request);
    final statusCode = response.response.statusCode;
    if (statusCode != null && statusCode > 199 && statusCode < 300) {
      return ApiResponse.success(null, statusCode);
    } else if (response.response.data["message"] != null &&
        response.response.data["message"].toString().isNotEmpty) {
      return ApiResponse.error(
          response.response.data["message"].toString(), 500);
    } else {
      return ApiResponse.error(unknownErrorMessage, 500);
    }
  }

  Future<ApiResponse<VerifyAuthResponse>> verifyAuthToken(
      String authToken) async {
    try {
      final response = await avexApiClient.verifyAuthToken(authToken);
      final statusCode = response.response.statusCode;
      return ApiResponse.success(
          VerifyAuthResponse.fromJson(response.data), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<GetExistenceResponse>> getUserExistence(
      String authToken) async {
    try {
      final response =
          await avexApiClient.getUserExistence("Bearer ${authToken}");
      final statusCode = response.response.statusCode;
      return ApiResponse.success(
          GetExistenceResponse.fromJson(response.data), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<String>> getNonce(String authToken) async {
    try {
      final response = await avexApiClient.getNonce("Bearer ${authToken}");
      final statusCode = response.response.statusCode;
      return ApiResponse.success(response.data.toString(), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<VerifyAuthResponse>> refreshAccessToken(
      String refreshToken) async {
    try {
      final response = await avexApiClient
          .refreshAccessToken(RefreshAccessTokenRequest(refresh: refreshToken));
      final statusCode = response.response.statusCode;
      return ApiResponse.success(
          VerifyAuthResponse.fromJson(response.data), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// handles error, and returns an ApiResponse based on the error
  Future<ApiResponse<DataType>> _handleError<DataType>(e) async {
    if (e.runtimeType == DioError) {
      final res = e.response;
      return ApiResponse<DataType>.error(
          e.message, e.response?.statusCode ?? -1);
    }
    return ApiResponse<DataType>.error(await _checkNetworkAndReturnError(), -1);
  }

  Future<String> _checkNetworkAndReturnError() async {
    return (await hasInternetAccess()) == false
        ? 'Oh snap! It seems you\'re offline.'
        : 'Something went wrong!';
  }

  Future<bool?> hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return null;
  }

  ApiService(Dio dio, this.sharedPref) {
    avexApiClient = AvexApiClient(dio);
  }

  void refreshAccessTokenToSharedPref() async {
    final prevRefreshToken = await sharedPref.instance.getString("refresh_token");
    final response = await refreshAccessToken(prevRefreshToken);
    // ignore: unrelated_type_equality_checks
    if (response.code < 300 && response.code >= 200) {
      try {
        sharedPref.instance
            .setString("access_token", response.data!.access.access)
            .then((value) => (value)
                ? {debugPrint("ACCESS TOKEN SAVED!!!")}
                : {debugPrint("ACCESS TOKEN NOT SAVED!!!")});
        sharedPref.instance
            .setString("refresh_token", response.data!.refresh.refresh)
            .then((value) => (value)
                ? {debugPrint("REFRESH TOKEN SAVED!!!")}
                : {debugPrint("REFRESH TOKEN NOT SAVED!!!")});
      } catch (e) {}
    } else {
      debugPrint(response.errorMessage);
    }
  }
}
