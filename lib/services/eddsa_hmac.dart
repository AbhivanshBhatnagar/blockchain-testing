import 'package:convert/convert.dart';
import 'package:bip32_ed25519/api.dart';
import 'package:eddsa_hmac/bip.service.dart';
import 'package:eddsa_hmac/eddsa.service.dart';
import 'package:eddsa_hmac/ethereum.service.dart';
import 'package:eddsa_hmac/message.service.dart';
import 'package:eddsa_hmac/path.service.dart';
import 'package:eddsa_hmac/shamir.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_project/services/api_services/api_response.dart';
import 'package:test_project/services/api_services/api_services.dart';
import 'package:web3dart/web3dart.dart';

import 'local_services/encrypted_shared_pref.dart';

final eddsaHmacProvider = Provider(
    (ref) => EddsaHmac(service: ref.read(apiServiceProvider), ref: ref));

class EddsaHmac {
  final ApiService service;
  final ProviderRef ref;
  EddsaHmac({required this.service, required this.ref});
  Future<ApiResponse> importSeedPhrase(String arguments) async {
    // Import Seed Phrase from User

    var safeMnemonic = importMnemonic(
        "kidney wealth trophy panel book car reveal shoulder gaze ski require exile");
    var backupShares = createBackupShares(safeMnemonic);
    print(backupShares); // Save these backup share to Drive, Email, Qrcode
    var seed = createWallet(safeMnemonic);
    var edwardsKey = createEdwardsKey(seed);
    await service.refreshAccessTokenToSharedPref();
    final accessToken = await ref
        .read(encryptedSharedPrefProvider)
        .instance
        .getString("access_token");
    final firstNonce = await service.getNonce(accessToken);
    if (firstNonce.status == ApiStatus.success) {
      var data1 = genreateShamirCreationMessage(
          backupShares[1], firstNonce.data!, edwardsKey);

      // print(backupShares[
      //     0]); // Send this key to API: SecretShare/CreateShare in the secret field
      // print(hex.encode(edwardsKey
      //     .publicKey)); // Send this key to API: SecretShare/CreateShare in the pub_key field
      // print(
      //     data1); // Send this signature to API: SecretShare/CreateShare in the signature field
      final response = await service.createSecret(accessToken, backupShares[1],
          hex.encode(edwardsKey.publicKey), data1);
      debugPrint(response.toString());
      var keys = createEthereumAccount(seed,
          0); // 0 is the index of the account, this will keep on incementing
      final secondNonce = await service.getNonce(accessToken);
      if (secondNonce.status == ApiStatus.success) {
        var data2 = genreateEthereumCreationMessage(secondNonce.data!, keys);

        // print(keys
        //     .address); // Send this key to API: Address/CreateAddress in the public_address field
        // print(
        //     "eth"); // Send this key to API: Address/CreateAddress in the chain field
        // print(
        //     data2); // Send this signature to API: Address/CreateAddress in the signature field
        final responseOfCreateAddress = await service.createAddress(
            accessToken, "eth", keys.address.toString(), data2);
        debugPrint(response.toString());
        return ApiResponse.success(null, 200);

        /// send result back
      }
    }
    return ApiResponse.error("SomethingWent Wrong", -1);
  }

  void createNewMemonicAndWallet(String nonce) {
    // Create new Memonic and Wallet
    var safeMnemonic = createNewMnemonic();
    var backupShares = createBackupShares(safeMnemonic);
    print(backupShares); // Save these backup share to Drive, Email, Qrcode
    var seed = createWallet(safeMnemonic);

    var edwardsKey = createEdwardsKey(seed);
    var data1 =
        genreateShamirCreationMessage(backupShares[1], nonce, edwardsKey);

    print(backupShares[
        1]); // Send this key to API: SecretShare/CreateShare in the secret field
    print(hex.encode(edwardsKey
        .publicKey)); // Send this key to API: SecretShare/CreateShare in the pub_key field
    print(
        data1); // Send this signature to API: SecretShare/CreateShare in the signature field

    var keys = createEthereumAccount(seed,
        0); // 0 is the index of the account, this will keep on incementing
    var data2 = genreateEthereumCreationMessage(nonce, keys);

    print(keys
        .address); // Send this key to API: Address/CreateAddress in the public_address field
    print(
        "eth"); // Send this key to API: Address/CreateAddress in the chain field
    print(
        data2); // Send this signature to API: Address/CreateAddress in the sign
  }

  void recoverSeedPhraseFromUserZ(List<String> arguments, String nonce) {
    // Recover Seed Phrase from User
    if (arguments.length < 2) {
      print('Please provide at least 2 shares');
      return;
    }
    var safeMnemonic = recoverMnemonic(arguments);
    var backupShares = createBackupShares(safeMnemonic);
    print(backupShares); // Save these backup share to Drive, Email, Qrcode
    var seed = createWallet(safeMnemonic);

    var edwardsKey = createEdwardsKey(seed);
    var data1 =
        genreateShamirCreationMessage(backupShares[1], nonce, edwardsKey);

    print(backupShares[
        1]); // Send this key to API: SecretShare/CreateShare in the secret field
    print(hex.encode(edwardsKey
        .publicKey)); // Send this key to API: SecretShare/CreateShare in the pub_key field
    print(
        data1); // Send this signature to API: SecretShare/CreateShare in the signature field

    var keys = createEthereumAccount(seed,
        0); // 0 is the index of the account, this will keep on incementing
    var data2 = genreateEthereumCreationMessage(nonce, keys);

    print(keys
        .address); // Send this key to API: Address/CreateAddress in the public_address field
    print(
        "eth"); // Send this key to API: Address/CreateAddress in the chain field
    print(
        data2); // Send this signature to API: Address/CreateAddress in the sign
  }

  String createNewMnemonic() {
    var mnemonic = genreateMnemonic();
    return mnemonic;
  }

  String recoverMnemonic(List<String> shares) {
    var recoverdSecret = combineShares(shares);
    var mnemonic = validateMnemonic(recoverdSecret);
    return mnemonic;
  }

  String importMnemonic(String unsafeMnemonic) {
    var mnemonic = validateMnemonic(unsafeMnemonic);
    return mnemonic;
  }

  Uint8List createWallet(String mnemonic) {
    var seed = generateSeed(mnemonic);
    return seed;
  }

  List<String> createBackupShares(String unsafeMnemonic) {
    var mnemonic = validateMnemonic(unsafeMnemonic);
    var shares = createShares(mnemonic);
    return shares;
  }

  ExtendedSigningKey createEdwardsKey(Uint8List seed) {
    var key = generateKeys(seed);
    return key;
  }

  Credentials createEthereumAccount(Uint8List seed, int index) {
    var chain = getChainFromSeed(seed);
    var path = constructPath(Coin.ethereum, index);
    var credentials = genrateCredentials(chain, path);
    return credentials;
  }

  String genreateEthereumCreationMessage(
      String nonce, Credentials credentials) {
    var rawMsg = encodeEtheruemCreationMessage(nonce, credentials);
    var signedMessage = hex.encode(signPersonalMessage(rawMsg, credentials));
    return signedMessage;
  }

  String genreateShamirCreationMessage(
      String secret, String nonce, ExtendedSigningKey key) {
    var rawMsg = encodeShamirCreationMessage(secret, nonce, key);
    var signedMessage = hex.encode(signData(rawMsg, key).signature);
    return signedMessage;
  }
}
