import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'dart:developer' as dev;

class Constants {
  static Credentials userCredentials = EthPrivateKey.fromHex(
      'e99c15b79e18f14a08fc209ac2b6a2f4c70ee878a6e421c667562a94d2aeef9f');
  static EthereumAddress ethereumAddress = userCredentials.address;
  static String address = userCredentials.address.hex;
  static List<DropdownMenuItem<String>> tokens = [
    DropdownMenuItem(child: Text("ETH"), value: "ETH"),
    DropdownMenuItem(child: Text("DAI"), value: "DAI"),
    DropdownMenuItem(child: Text("UDSC"), value: "USDC"),
    DropdownMenuItem(child: Text("LINK"), value: "LINK"),
    DropdownMenuItem(child: Text("USDT"), value: "USDT"),
    DropdownMenuItem(child: Text("UNI"), value: "UNI"),
    // DropdownMenuItem(child: Text("Wrapped BTC"), value: "WBTC"),
    // DropdownMenuItem(child: Text("FRAX"), value: "FRAX"),
    // DropdownMenuItem(child: Text("USD Mapped Token"), value: "USDM"),
    // DropdownMenuItem(child: Text("WETH"), value: "WETH"),
    // DropdownMenuItem(child: Text("BUSD"), value: "BUSD"),
  ];
  static List<DropdownMenuItem<String>> slippage = [
    DropdownMenuItem(child: Text("1%"), value: "0.01"),
    DropdownMenuItem(child: Text("2%"), value: "0.02"),
    DropdownMenuItem(child: Text("3%"), value: "0.03"),
    DropdownMenuItem(child: Text("5%"), value: "0.05"),
  ];
  static Map<String, String> tokenAddressList = {
    "ETH": "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
    "DAI": "0xdc31Ee1784292379Fbb2964b3B9C4124D8F89C60",
    "UNI": "0x1f9840a85d5af5bf1d1762f925bdaddc4201f984",
    "USDC": "0x07865c6e87b9f70255377e024ace6630c1eaa37f",
    "USDT": "0x56705db9f87c8a930ec87da0d458e00a657fccb0 ",
    "LINK": "0xe9c4393a23246293a8D31BF7ab68c17d4CF90A29"
  };
  static TextStyle h1poppinsStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 45,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  );
  static TextStyle h2poppinsStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 40,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  );
  static TextStyle h3poppinsStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  );
  static TextStyle h4poppinsStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
  );
  static TextStyle h5poppinsStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
  );

  static TextStyle h6poppinsStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
  );
  static TextStyle h7poppinsStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 8,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
  );
  static ButtonStyle roundCornerBlue = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF2f89a6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(37.0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  );
  static ButtonStyle roundCornerBlack = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF222529),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(37.0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  );
  static ButtonStyle rectRoundCornerBlue = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF2f89a6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  );
  static ButtonStyle rectRoundCornerBlack = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF222529),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  );
  createWallet() {
    var rng = Random.secure();
    Credentials random = EthPrivateKey.createRandom(rng);
    dev.log(random.address.hex);
  }
}
