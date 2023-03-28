import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/services/eddsa_hmac.dart';
import 'package:test_project/services/local_services/encrypted_shared_pref.dart';

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
      : super(const SeedRecoveryStateNotifierState()) {}

  void moveToNextScreen() {
    // AndroidGoogleDrivePlatformChannel.invoke();
  }
  void driveRecovery() {
    final eddsaHmac = ref.read(eddsaHmacProvider);
    eddsaHmac.createNewMemonicAndWallet((token) async {
      AndroidGoogleDrivePlatformChannel.signInWithGoogle();
      await ref
          .read(encryptedSharedPrefProvider)
          .instance
          .setString("drive_token", token);
      state = state.copyWith(driveKey: token);
    }, (token) async {
      await ref
          .read(encryptedSharedPrefProvider)
          .instance
          .setString("qr_code_token", token);

      state = state.copyWith(qrKey: token);
    });
  }

  void sendToApi() {}
}

@freezed
class SeedRecoveryStateNotifierState with _$SeedRecoveryStateNotifierState {
  const factory SeedRecoveryStateNotifierState({
    @Default(SeedRecoveryStateNotifierStatus.initial)
        SeedRecoveryStateNotifierStatus status,
    String? errorMessage,
    @Default(0) int noOfSteps,
    @Default("") String driveKey,
    @Default("") String qrKey,
  }) = _SeedRecoveryStateNotifierState;
}

enum SeedRecoveryStateNotifierStatus { initial, loading, error, loaded }
