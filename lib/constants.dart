import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class Constants {
  static Credentials userCredentials = EthPrivateKey.fromHex(
      'e99c15b79e18f14a08fc209ac2b6a2f4c70ee878a6e421c667562a94d2aeef9f');
  static EthereumAddress ethereumAddress = userCredentials.address;
  static String address = userCredentials.address.hex;
  static List<DropdownMenuItem<String>> tokens = [
    DropdownMenuItem(child: Text("ETH"), value: "ETH"),
    DropdownMenuItem(child: Text("WETH"), value: "WETH"),
    DropdownMenuItem(child: Text("DAI"), value: "DAI"),
    DropdownMenuItem(child: Text("UDSC"), value: "USDC"),
    DropdownMenuItem(child: Text("Wrapped BTC"), value: "WBTC"),
    DropdownMenuItem(child: Text("UDST"), value: "UDST"),
    DropdownMenuItem(child: Text("FRAX"), value: "FRAX"),
    DropdownMenuItem(child: Text("USD Mapped Token"), value: "USDM"),
    DropdownMenuItem(child: Text("UNI"), value: "UNI"),
    DropdownMenuItem(child: Text("BUSD"), value: "BUSD"),
  ];
  static List<DropdownMenuItem<String>> slippage = [
    DropdownMenuItem(child: Text("1%"), value: "0.01"),
    DropdownMenuItem(child: Text("2%"), value: "0.02"),
    DropdownMenuItem(child: Text("3%"), value: "0.03"),
    DropdownMenuItem(child: Text("5%"), value: "0.05"),
  ];
}
