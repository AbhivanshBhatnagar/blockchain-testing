import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:eth_sig_util/eth_sig_util.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // static var rng = Random.secure();
  // Credentials random = EthPrivateKey.createRandom(rng);
  static var mssg = "hello";
  Credentials fromHex = EthPrivateKey.fromHex(
      "e99c15b79e18f14a08fc209ac2b6a2f4c70ee878a6e421c667562a94d2aeef9f");
  static var httpClient = http.Client();
  static var url = Uri.parse("https://rpc.ankr.com/eth_goerli").toString();
  String trans = '';
  var ethClient = Web3Client(url, httpClient);
  late String signature;
  void send() async {
    var GP = await ethClient.getGasPrice();
    var sign = await fromHex
        .signPersonalMessageToUint8List(Uint8List.fromList(utf8.encode(mssg)));
    dev.log(GP.toString());
    trans = await ethClient.sendTransaction(
      fromHex,
      Transaction(
        from: fromHex.address,
        to: EthereumAddress.fromHex(
            '0xAe2011458cb51ab4c4dBE6139A5C94aA50E56F7F'),
        gasPrice: GP,
        maxGas: 21000,
        value: EtherAmount.fromInt(EtherUnit.gwei, 10),
      ),
      chainId: 5,
    );
    // dev.log(trans.startsWith("0x").toString());
    TransactionInformation? trans_details =
        await ethClient.getTransactionByHash(trans);
    // dev.log(trans_details!.blockNumber.toString());
    getbalance();
  }

  void getbalance() async {
    dev.log(fromHex.address.toString());
    EtherAmount balance = await ethClient.getBalance(fromHex.address);

    dev.log(balance.getInWei.toString());
  }

  late Timer _timer;
  late TransactionReceipt trans_receipt;
  void timer() {
    const oneSec = Duration(seconds: 1, milliseconds: 500);
    _timer = Timer.periodic(oneSec, (Timer t) async {
      try {
        // TransactionInformation? TRANSINFO =
        //     await ethClient.getTransactionByHash(trans);
        // dev.log(TRANSINFO!.blockNumber.isPending.toString());
        // var BNO = await ethClient.getBlockNumber();
        // dev.log(BNO.toString());
        // if (!TRANSINFO.blockNumber.isPending) {
        //   dev.log(TRANSINFO.blockNumber.toString());
        //   _timer.cancel();
        //   // trans_receipt=await TransactionReceipt.fromMap(map)
        // }
        TransactionInformation? currentSentTransaction =
            await ethClient.getTransactionByHash(trans);
        dev.log(currentSentTransaction!.blockNumber.toBlockParam() +
            currentSentTransaction.hash);
        int currentBlockNumber = await ethClient.getBlockNumber();
        dev.log(currentBlockNumber.toString());
      } catch (e) {
        dev.log(e.toString());
      }
    });
  }

  void sign() {
    final sign = fromHex
        .signPersonalMessageToUint8List(Uint8List.fromList(utf8.encode(mssg)));
    final signed =
        fromHex.signToEcSignature(Uint8List.fromList(utf8.encode(mssg)));
    dev.log(sign.toString());
    dev.log(signed.v.toString());
    var xyz = EthSigUtil.signPersonalMessage(
        message: Uint8List.fromList(utf8.encode(mssg)),
        privateKey:
            "e99c15b79e18f14a08fc209ac2b6a2f4c70ee878a6e421c667562a94d2aeef9f");
    dev.log(xyz);
    String address = EthSigUtil.recoverPersonalSignature(
        signature: xyz, message: Uint8List.fromList(utf8.encode(mssg)));
    dev.log(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(fromHex.address.hex),
            ElevatedButton(onPressed: send, child: Text("Send")),
            ElevatedButton(onPressed: timer, child: Text("check")),
            ElevatedButton(onPressed: sign, child: Text("sign"))
          ],
        ),
      ),
    );
  }
}
// 0x7F3BD1Fa0d241bEd9D7bb81294b78daBa182287F