import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_project/services/api_services/api_client/api_refresh_ext.dart';

import '../../../services/api_services/api_response.dart';
import '../../../services/api_services/api_services.dart';
import '../../../services/eddsa_hmac.dart';
import '../../../services/local_services/encrypted_shared_pref.dart';

part 'restore_existing_account_state_notifier.freezed.dart';

final restoreExistingAccountStateNotifierProvider =
    StateNotifierProvider.autoDispose<RestoreExistingAccountStateNotifier,
            RestoreExistingAccountStateNotifierState>(
        ((ref) => RestoreExistingAccountStateNotifier(
            apiServices: ref.read(apiServiceProvider),
            eddsaHmac: ref.read(eddsaHmacProvider),
            ref: ref)));

class RestoreExistingAccountStateNotifier
    extends StateNotifier<RestoreExistingAccountStateNotifierState> {
  final StateNotifierProviderRef ref;
  final ApiService apiServices;
  final EddsaHmac eddsaHmac;

  RestoreExistingAccountStateNotifier(
      {required this.apiServices, required this.ref, required this.eddsaHmac})
      : super(const RestoreExistingAccountStateNotifierState());

  void inputSeedPhrase(String seed) {
    state = state.copyWith(seedPhraseList: seed);
  }

  void onSeedPhraseSubmitted() async {
    debugPrint(state.seedPhraseList);
    final refreshToken = await ref
        .read(encryptedSharedPrefProvider)
        .instance
        .getString("refresh_token");
    final freshAuthToken =
        await ref.read(apiServiceProvider).refreshAccessToken(refreshToken);
    if(freshAuthToken.status==ApiStatus.success){
      final accessToken = freshAuthToken.data!.access.access;
      final nonce = await ref.read(apiServiceProvider).getNonce(accessToken);
      if (nonce.status == ApiStatus.success) {
        eddsaHmac.importSeedPhrase(state.seedPhraseList, nonce.data!);
      }
    }
  }
}

@freezed
class RestoreExistingAccountStateNotifierState
    with _$RestoreExistingAccountStateNotifierState {
  const factory RestoreExistingAccountStateNotifierState({
    @Default(RestoreExistingAccountStateNotifierStatus.initial)
        RestoreExistingAccountStateNotifierStatus status,
    @Default("") String seedPhraseList,
    String? errorMessage,
  }) = _RestoreExistingAccountStateNotifierState;
}

enum RestoreExistingAccountStateNotifierStatus {
  initial,
  loading,
  error,
  loaded
}
