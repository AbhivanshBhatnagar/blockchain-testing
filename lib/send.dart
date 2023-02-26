import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:test_project/constants.dart';
import 'package:test_project/transaction.dart';
import 'package:web3dart/web3dart.dart';
import 'package:ens_dart/ens_dart.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  GlobalKey<FormState> addressKey = GlobalKey<FormState>();
  GlobalKey<FormState> valueKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final _valueController = TextEditingController();
  static var httpClient = http.Client();
  static String rpc_url = "https://eth.llamarpc.com";
  static var ethClient = Web3Client(rpc_url, httpClient);
  final ensClient = Ens(client: ethClient);
  static var addr = '';
  late int value;
  String selectedValue1 = "ETH";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: addressKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                  onEditingComplete: () async {
                    if (addressController.text.endsWith(".eth")) {
                      try {
                        var ens = await fetchENS(addressController.text);
                        addr = ens;
                      } catch (e) {}
                    } else if (addressController.text.startsWith("0x") &&
                        addressController.text.length == 42) {
                      addr = addressController.text;
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please enter a valid ENS or Address");
                    }
                  },
                  // cursorColor: Color(0xFF064848),
                  controller: addressController,
                  decoration: InputDecoration(
                      label: Text(
                    "Address",
                  )),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Address is required"),
                  ]),
                  autovalidateMode: AutovalidateMode.onUserInteraction),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        items: Constants.tokens,
                        value: selectedValue1,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue1 = value.toString();
                          });
                          log(value.toString());
                        })),
              ),
              Expanded(
                child: Form(
                  key: valueKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextFormField(
                        // onChanged: ,
                        keyboardType: TextInputType.number,
                        controller: _valueController,
                        decoration: const InputDecoration(
                            label: Text(
                          "value",
                        )),
                        autovalidateMode: AutovalidateMode.onUserInteraction),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                // value =
                //     (_valueController.text * math.pow(10, 9).toInt()) as int;
                var maxGas = await WalletTransaction().web3client.estimateGas();
                var gasprice =
                    await WalletTransaction().web3client.getGasPrice();
                if (addressController.text.isNotEmpty &&
                    _valueController.text.isNotEmpty) {
                  double sendValue = double.parse(_valueController.text);
                  sendValue = sendValue * math.pow(10, 18);
                  WalletTransaction().sendTransaction(
                      transactiondata: Transaction(
                          from: Constants.ethereumAddress,
                          to: EthereumAddress.fromHex(addr),
                          value: EtherAmount.fromBigInt(
                              EtherUnit.wei,
                              BigInt.from(
                                  double.parse(sendValue.toInt().toString()))),
                          maxGas: maxGas.toInt(),
                          gasPrice: gasprice));
                } else {
                  Fluttertoast.showToast(
                      msg: "Please enter a valid ENS or Address or Value");
                }
              },
              child: Text("Send"))
        ],
      )),
    );
  }

  fetchENS(var add) async {
    var ens;
    try {
      add = await ensClient.withName(add).getAddress();
      if (add.hex.toString().contains("Service Unavailable") ||
          add.hex
              .toString()
              .contains("0x0000000000000000000000000000000000000000") ||
          add.hex.toString().contains("Connection")) {
        Fluttertoast.showToast(msg: "Couldnt find ENS, Please try again");
      } else {
        Fluttertoast.showToast(msg: "Found a valid ENS");
        ens = add.toString();
      }
      // log(add.toString());
    } catch (e) {
      // log(e.toString());
    }
    return ens;
  }
}
