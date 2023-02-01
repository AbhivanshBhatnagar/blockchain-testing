import 'package:web3dart/web3dart.dart';

class Constants {
  static Credentials userCredentials = EthPrivateKey.fromHex(
      'e99c15b79e18f14a08fc209ac2b6a2f4c70ee878a6e421c667562a94d2aeef9f');
  static EthereumAddress ethereumAddress = userCredentials.address;
  static String address = userCredentials.address.hex;
}
