import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/api_services/api_response.dart';
import '../../../services/api_services/api_services.dart';

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

  void verifyDynamicLink() async {
    String authToken="";
    final response = await apiServices.verifyAuthToken(authToken);
    // ignore: unrelated_type_equality_checks
    if (response.code < 300 && response.code >= 200) {
      debugPrint("SUCCESS");
    } else {
      debugPrint(response.errorMessage);
    }
  }
}

@freezed
class DynamicLinkProcessingStateNotifierState
    with _$DynamicLinkProcessingStateNotifierState {
  const factory DynamicLinkProcessingStateNotifierState({
    @Default(DynamicLinkProcessingStateNotifierStatus.initial)
        DynamicLinkProcessingStateNotifierStatus status,
    String? errorMessage,
  }) = _DynamicLinkProcessingStateNotifierState;
}

enum DynamicLinkProcessingStateNotifierStatus {
  initial,
  loading,
  error,
  loaded
}
