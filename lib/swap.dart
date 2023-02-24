import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_project/constants.dart';
import 'package:test_project/dummy_swap.dart';
import 'package:test_project/getTokens.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  GlobalKey<FormState> _token1Key = GlobalKey<FormState>();
  GlobalKey<FormState> _token2Key = GlobalKey<FormState>();
  TextEditingController _token1Controller = TextEditingController();
  TextEditingController _token2Controller = TextEditingController();
  String selectedValue1 = "ETH";
  String selectedValue2 = "DAI";
  String exchangePrice = '';
  String slippage = '0';
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                      menuMaxHeight: MediaQuery.of(context).size.height / 5,
                      underline: SizedBox(),
                      items: Constants.tokens,
                      value: selectedValue1,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue1 = value!;
                        });
                        log(value.toString());
                      }),
                  SizedBox(
                    width: 70,
                  ),
                  Expanded(
                    child: Form(
                        child: TextFormField(
                      onEditingComplete: () async {
                        exchangePrice = await WalletSwap().qoute0x(
                            buytoken: Constants.tokenAddressList[selectedValue2]
                                .toString(),
                            selltoken: Constants
                                .tokenAddressList[selectedValue1]
                                .toString(),
                            amount: double.parse(_token1Controller.text));
                        _token2Controller.text = exchangePrice;
                        setState(() {});
                      },
                      key: _token1Key,
                      controller: _token1Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text(
                        "Value",
                      )),
                    )),
                  ),
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                      underline: SizedBox(),
                      items: Constants.tokens,
                      value: selectedValue2,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue2 = value!;
                        });
                        log(value.toString());
                      }),
                  SizedBox(
                    width: 70,
                  ),
                  Expanded(
                    child: Form(
                        child: TextFormField(
                      onEditingComplete: () async {
                        exchangePrice = await WalletSwap().qoute0x(
                            buytoken: Constants.tokenAddressList[selectedValue1]
                                .toString(),
                            selltoken: Constants
                                .tokenAddressList[selectedValue2]
                                .toString(),
                            amount: double.parse(_token2Controller.text));
                        _token1Controller.text = exchangePrice;
                        setState(() {});
                      },
                      key: _token2Key,
                      controller: _token2Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text(
                        "Value",
                      )),
                    )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // DropdownButton(
                  //     underline: SizedBox(),
                  //     hint: Text(
                  //         "Max Slippage = ${double.parse(slippage) * 100}%"),
                  //     items: Constants.slippage,
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         slippage = value!;
                  //       });
                  //       log(value.toString());
                  //     }),
                  ElevatedButton(
                      onPressed: () {
                        WalletSwap().swap(
                            token1: Constants.tokenAddressList[selectedValue1]
                                .toString(),
                            token2: Constants.tokenAddressList[selectedValue2]
                                .toString(),
                            amount: (double.parse(_token1Controller.text)));
                      },
                      child: Text("Swap")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
