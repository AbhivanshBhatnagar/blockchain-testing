import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/services/api_services/api_client/avex_api_client.dart';
import 'package:test_project/services/api_services/api_response.dart';

import '../../models/models.dart';
import '../dio_provider.dart';

final apiServiceProvider =
    Provider<ApiService>((ref) => ApiService(ref.read(dioProvider)));

class ApiService {
  late final AvexApiClient avexApiClient;
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

  ApiService(Dio dio) {
    avexApiClient = AvexApiClient(dio);
  }
}
