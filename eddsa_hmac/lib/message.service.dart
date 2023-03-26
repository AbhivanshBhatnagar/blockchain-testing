import 'dart:convert';
import 'package:bip32_ed25519/api.dart';
import 'package:convert/convert.dart';
import 'package:web3dart/web3dart.dart';

String encodeShamirCreationMessage(
    String secret, String nonce, ExtendedSigningKey key) {
  return jsonEncode({
    'secret': secret,
    'pub_key': hex.encode(key.publicKey),
    'nonce': nonce,
  });
}

String encodeEtheruemCreationMessage(String nonce, Credentials key) {
  return jsonEncode({
    'public_address': key.address.hexNo0x,
    'chain': "eth",
    'nonce': nonce,
  });
}
