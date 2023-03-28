import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/services/eddsa_hmac.dart';

import '../../../native/android/android_google_drive_platform_channel.dart';
import '../../../services/api_services/api_response.dart';
import '../../../services/api_services/api_services.dart';

part 'seed_recovery_state_notifier.freezed.dart';

final seedRecoveryStateNotifierProvider = StateNotifierProvider.autoDispose<
        SeedRecoveryStateNotifier, SeedRecoveryStateNotifierState>(
    ((ref) => SeedRecoveryStateNotifier(
        apiServices: ref.read(apiServiceProvider), ref: ref)));

class SeedRecoveryStateNotifier
    extends StateNotifier<SeedRecoveryStateNotifierState> {
  final StateNotifierProviderRef ref;
  final ApiService apiServices;

  SeedRecoveryStateNotifier({required this.apiServices, required this.ref})
      : super(const SeedRecoveryStateNotifierState()) {
    final eddsaHmac = ref.read(eddsaHmacProvider);
    
    eddsaHmac.createNewMemonicAndWallet()
  }

  void moveToNextScreen() {
    // AndroidGoogleDrivePlatformChannel.invoke();
  }
  void driveRecovery() {}

  void sendToApi() {}
}

@freezed
class SeedRecoveryStateNotifierState with _$SeedRecoveryStateNotifierState {
  const factory SeedRecoveryStateNotifierState({
    @Default(SeedRecoveryStateNotifierStatus.initial)
        SeedRecoveryStateNotifierStatus status,
    String? errorMessage,
    @Default(0) int noOfSteps,
  }) = _SeedRecoveryStateNotifierState;
}

enum SeedRecoveryStateNotifierStatus { initial, loading, error, loaded }
