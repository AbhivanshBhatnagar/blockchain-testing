import 'dart:convert';
import 'package:bip32_ed25519/api.dart';

ExtendedSigningKey generateKeys(Uint8List seed) {
  if (seed.length == 64) {
    seed = seed.sublist(0, 32);
  }
  return ExtendedSigningKey.fromSeed(seed);
}

SignedMessage signData(String message, ExtendedSigningKey key) {
  return key.sign(utf8.encode(message));
}
