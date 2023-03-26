import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/api_services/api_response.dart';
import '../../../services/api_services/api_services.dart';
import '../../../services/local_services/encryoted_shared_pref.dart';

part 'dynamic_link_processing_state_notifier.freezed.dart';

final dynamicLinkProcessingStateNotifierProvider =
    StateNotifierProvider.autoDispose<DynamicLinkProcessingStateNotifier,
            DynamicLinkProcessingStateNotifierState>(
        ((ref) => DynamicLinkProcessingStateNotifier(
            apiServices: ref.read(apiServiceProvider), ref: ref)));

class DynamicLinkProcessingStateNotifier
    extends StateNotifier<DynamicLinkProcessingStateNotifierState> {
  final StateNotifierProviderRef ref;
  final ApiService apiServices;

  DynamicLinkProcessingStateNotifier(
      {required this.apiServices, required this.ref})
      : super(const DynamicLinkProcessingStateNotifierState());

  void verifyDynamicLink(String authToken) async {
    final response = await apiServices.verifyAuthToken(authToken);
    // ignore: unrelated_type_equality_checks
    if (response.code < 300 && response.code >= 200) {
      try {
        ref
            .read(encryptedSharedPrefProvider)
            .instance
            .setString("access_token", response.data!.access.access)
            .then((value) => (value)
                ? {debugPrint("ACCESS TOKEN SAVED!!!")}
                : {debugPrint("ACCESS TOKEN NOT SAVED!!!")});
        ref
            .read(encryptedSharedPrefProvider)
            .instance
            .setString("refresh_token", response.data!.refresh.refresh)
            .then((value) => (value)
                ? {debugPrint("REFRESH TOKEN SAVED!!!")}
                : {debugPrint("REFRESH TOKEN NOT SAVED!!!")});
        state = state.copyWith(
            status: DynamicLinkProcessingStateNotifierStatus.dynamicLinkVerified,
            accessToken: response.data!.access.access,
            refreshToken: response.data!.refresh.refresh);
      } catch (e) {}
    } else {
      debugPrint(response.errorMessage);
      try {
        state = state.copyWith(
            status: DynamicLinkProcessingStateNotifierStatus.error,
            errorMessage: response.errorMessage);
      } catch (e) {}
    }
  }

  void checkWhetherUserExists() async {
    final response =
        await apiServices.getUserExistence(state.accessToken ?? "");
    if (response.code < 300 && response.code >= 200) {
      try {
        state = state.copyWith(
            status: DynamicLinkProcessingStateNotifierStatus.loaded);
      } catch (e) {}
    } else {
      debugPrint(response.errorMessage);
      try {
        state = state.copyWith(
            status: DynamicLinkProcessingStateNotifierStatus.error,
            errorMessage: response.errorMessage);
      } catch (e) {}
    }
  }
}

@freezed
class DynamicLinkProcessingStateNotifierState
    with _$DynamicLinkProcessingStateNotifierState {
  const factory DynamicLinkProcessingStateNotifierState(
      {@Default(DynamicLinkProcessingStateNotifierStatus.initial)
          DynamicLinkProcessingStateNotifierStatus status,
      String? errorMessage,
      String? accessToken,
      String? refreshToken}) = _DynamicLinkProcessingStateNotifierState;
}

enum DynamicLinkProcessingStateNotifierStatus {
  initial,
  loading,
  error,
  dynamicLinkVerified,
  loaded
}
