import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
// import 'dart:js';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_project/key_sig.dart';
import 'package:test_project/transaction.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'constants.dart';

class Swap extends StatefulWidget {
  Swap({super.key});
  static String pvtkey =
      "e99c15b79e18f14a08fc209ac2b6a2f4c70ee878a6e421c667562a94d2aeef9f";
  static String user_address = _credentials.address.hex.toString();
  static Credentials _credentials = EthPrivateKey.fromHex(pvtkey);
  static var httpClient = http.Client();
  static String rpc_url =
      "https://goerli.infura.io/v3/5d158c71773c4d869a97405bef38704f";
  static String daiAddress = "0xE68104D83e647b7c1C15a91a8D8aAD21a51B3B3E";
  static String ethAddress = '0x0000000000000000000000000000000000000000';
  var ethClient = Web3Client(rpc_url, httpClient);
  static Map<String, String> check_allowance_query_params = {
    // 'sellToken': '0xE68104D83e647b7c1C15a91a8D8aAD21a51B3B3E',
    // 'buyToken': '0x0000000000000000000000000000000000000000',
    // 'amount': '100000000000000000',
    // 'slippage': '1',
    // 'disableEstimate': 'false',
    // 'allowPartialFill': 'false'
    'takerAddress': user_address,
    'sellToken': '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
    'buyToken': '0xE68104D83e647b7c1C15a91a8D8aAD21a51B3B3E',
    'sellAmount': '1000000000000000'
  };

  Future<DeployedContract> loadContract({String tokenAdress = ''}) async {
    String contractAddress = tokenAdress;
    // String abi = await rootBundle.loadString("./lib.json");

    final contract = DeployedContract(
        ContractAbi.fromJson(
            jsonEncode([
              {
                "constant": true,
                "inputs": [],
                "name": "name",
                "outputs": [
                  {"name": "", "type": "string"}
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": false,
                "inputs": [
                  {"name": "_spender", "type": "address"},
                  {"name": "_value", "type": "uint256"}
                ],
                "name": "approve",
                "outputs": [
                  {"name": "", "type": "bool"}
                ],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
              },
              {
                "constant": true,
                "inputs": [],
                "name": "totalSupply",
                "outputs": [
                  {"name": "", "type": "uint256"}
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": false,
                "inputs": [
                  {"name": "_from", "type": "address"},
                  {"name": "_to", "type": "address"},
                  {"name": "_value", "type": "uint256"}
                ],
                "name": "transferFrom",
                "outputs": [
                  {"name": "", "type": "bool"}
                ],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
              },
              {
                "constant": true,
                "inputs": [],
                "name": "decimals",
                "outputs": [
                  {"name": "", "type": "uint8"}
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": true,
                "inputs": [
                  {"name": "_owner", "type": "address"}
                ],
                "name": "balanceOf",
                "outputs": [
                  {"name": "balance", "type": "uint256"}
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": true,
                "inputs": [],
                "name": "symbol",
                "outputs": [
                  {"name": "", "type": "string"}
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": false,
                "inputs": [
                  {"name": "_to", "type": "address"},
                  {"name": "_value", "type": "uint256"}
                ],
                "name": "transfer",
                "outputs": [
                  {"name": "", "type": "bool"}
                ],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
              },
              {
                "constant": true,
                "inputs": [
                  {"name": "_owner", "type": "address"},
                  {"name": "_spender", "type": "address"}
                ],
                "name": "allowance",
                "outputs": [
                  {"name": "", "type": "uint256"}
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "payable": true,
                "stateMutability": "payable",
                "type": "fallback"
              },
              {
                "anonymous": false,
                "inputs": [
                  {"indexed": true, "name": "owner", "type": "address"},
                  {"indexed": true, "name": "spender", "type": "address"},
                  {"indexed": false, "name": "value", "type": "uint256"}
                ],
                "name": "Approval",
                "type": "event"
              },
              {
                "anonymous": false,
                "inputs": [
                  {"indexed": true, "name": "from", "type": "address"},
                  {"indexed": true, "name": "to", "type": "address"},
                  {"indexed": false, "name": "value", "type": "uint256"}
                ],
                "name": "Transfer",
                "type": "event"
              }
            ]),
            "Dai Stablecoin"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  void swap(
      {String token1 = '', String token2 = '', double amount = 0.0}) async {
    DeployedContract daiContract = await loadContract(tokenAdress: daiAddress);
    DeployedContract ethContract = await loadContract(tokenAdress: ethAddress);
    var decimalsfunc = daiContract.function('decimals');
    var senderAddress = EthereumAddress.fromHex(_credentials.address.hex);
    final getDecimals = await ethClient.call(
        sender: senderAddress,
        contract: daiContract,
        function: decimalsfunc,
        params: []);
    // log(get_decimals.first.toString());

    double exchangeAmount = amount * math.pow(10, getDecimals[0].toInt());
    log(exchangeAmount.toString());
    // log(exchange_amount.toString());
    var func = daiContract.function("allowance");
    final getAllowance = await ethClient.call(
        sender: senderAddress,
        contract: daiContract,
        function: func,
        params: [
          EthereumAddress.fromHex(_credentials.address.hex),
          EthereumAddress.fromHex(daiAddress)
        ]);
    int allowance = getAllowance[0].toInt();
    if (allowance < exchangeAmount) {
      var func = daiContract.function("approve");
      final approve = await ethClient.call(
          sender: senderAddress,
          contract: daiContract,
          function: func,
          params: [
            EthereumAddress.fromHex(_credentials.address.hex),
            BigInt.from(allowance)
          ]);
      log(approve.toString());
    }
    check_allowance_0x();
  }

  // void check_allowance() async {
  //   // log(_credentials.address.hex);

  //   var httpsUri = Uri(
  //       scheme: 'https',
  //       host: 'api.1inch.io',
  //       path: '/v4.0/$chain_id/approve/allowance',
  //       queryParameters: check_allowance_query_params);
  //   print(httpsUri);
  //   http.Response response = await http.get(httpsUri);
  //   try {
  //     if (response.statusCode == 200) {
  //       log(response.body.toString());
  //       // ethClient.sendTransaction(_credentials, Transaction());
  //     } else {
  //       log(response.body.toString());
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  void check_allowance_0x() async {
    // log(_credentials.address.hex);
    var httpsUri = Uri(
        scheme: 'https',
        host: 'goerli.api.0x.org',
        path: '/swap/v1/quote',
        queryParameters: check_allowance_query_params);
    // print(httpsUri);
    http.Response response = await http.get(httpsUri);
    try {
      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        // log(data.toString());
        // try {
        //   var sig = _credentials.signPersonalMessageToUint8List(
        //       Uint8List.fromList(utf8.encode(data.toString())));
        //   log(sig.toString());
        //   try {
        //     ethClient.sendTransaction(
        //         _credentials,
        //         Transaction(
        //             data: Uint8List.fromList(utf8.encode(data.toString()))));
        //   } catch (e) {
        //     log(e.toString());
        //   }
        // } catch (e) {
        //   log(e.toString());
        // }
        final transaction = Transaction(
          from: EthereumAddress.fromHex(data["from"]),
          to: EthereumAddress.fromHex(data['to']),
          // maxGas: hexToDartInt(data['gas']),
          // gasPrice: EtherAmount.inWei(hexToInt(data['gasPrice'])),
          value: EtherAmount.inWei(hexToInt(data['value'])),
          data: hexToBytes(data['data']),
        );
        // ethClient.sendTransaction(_credentials, transaction);
        try {
          var sig = await _credentials.signPersonalMessageToUint8List(
              Uint8List.fromList(utf8.encode(transaction.toString())));
          log(sig.toString());
          try {
            // await ethClient.sendRawTransaction(sig);
            await WalletTransaction()
                .sendTransaction(transactiondata: transaction);

            // await ethClient.sendTransaction(_credentials, transaction);
          } catch (e) {
            Fluttertoast.showToast(msg: e.toString());
          }
        } catch (e) {
          Fluttertoast.showToast(msg: e.toString());
        }
      } else {
        log(response.body.toString());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // void ask_allowance() async {
  //   // log(_credentials.address.hex);
  //   var httpsUri = Uri(
  //       scheme: 'https',
  //       host: 'api.1inch.io',
  //       path: '/v4.0/$chain_id/approve/transaction',
  //       queryParameters: ask_allowance_query_params);
  //   print(httpsUri);
  //   http.Response response = await http.get(httpsUri);
  //   try {
  //     if (response.statusCode == 200) {
  //       allowance_transaction = response.body;
  //       String xyz =
  //           KeySig().sign_transaction(transaction: allowance_transaction);
  //       // String final_transaction_hash = await ethClient.sendRawTransaction(
  //       // Uint8List.fromList(utf8.encode(allowance_transaction)));
  //       // log(final_transaction_hash);

  //       // log(response.body.toString());
  //       // log(xyz);
  //       final http.Response response2 = await http.post(
  //         Uri.parse(broadcastApiUrl),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //         },
  //         body: jsonEncode(<String, String>{"rawTransaction": xyz}),
  //       );
  //       log(response2.body.toString());
  //     } else {
  //       log(response.body.toString());
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  @override
  State<Swap> createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var maxGas = await WalletTransaction().web3client.estimateGas();
                var gasprice =
                    await WalletTransaction().web3client.getGasPrice();
                WalletTransaction().sendTransaction(
                  transactiondata: Transaction(
                      from: Constants.ethereumAddress,
                      to: EthereumAddress.fromHex(
                          "0x35EFceC1182d758A3c7e96DDaDE4064222d7C270"),
                      value: EtherAmount.inWei(
                        BigInt.from(1000000000000000),
                      ),
                      maxGas: maxGas.toInt(),
                      gasPrice: gasprice),
                );
              },
              child: Text("send"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("allow exchange"),
            ),
          ],
        ),
      ),
    );
  }
}
