import 'dart:convert';
import 'package:convert/convert.dart';
import 'dart:typed_data';
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:web3dart/web3dart.dart';

Chain getChainFromSeed(Uint8List seed) {
  return Chain.seed(hex.encode(seed));
}

Credentials genrateCredentials(Chain chain, String path) {
  ExtendedKey key = chain.forPath(path);
  return EthPrivateKey.fromHex(key.privateKeyHex());
}

Uint8List signPersonalMessage(String message, Credentials credentials) {
  var sign = credentials
      .signPersonalMessageToUint8List(Uint8List.fromList(utf8.encode(message)));
  return sign;
}
