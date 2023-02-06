import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/constants.dart';
import 'package:test_project/dummy_swap.dart';
import 'package:test_project/transaction.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:math' as math;

class WalletLendBorrow {
  static var httpClient = http.Client();
  static String rpc_url =
      "https://goerli.infura.io/v3/a1a50b6285a944d98e643e6efe0bc6bf";
  var ethClient = Web3Client(rpc_url, httpClient);
  Future<DeployedContract> loadContract() async {
    String abi =
        await rootBundle.loadString("contracts/lend_borrow_contract.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "Aave Pool"),
        EthereumAddress.fromHex("0x7b5C526B7F8dfdff278b4a3e045083FBA4028790"));
    return contract;
  }

  callContract(String funcName, List<dynamic> args) async {
    var contract = await loadContract();
    var func = contract.function(funcName);
    var result = await ethClient.call(
        sender: Constants.ethereumAddress,
        contract: contract,
        function: func,
        params: args);
    log(result.toString());
  }

  approveERC20({String ERC20Address = '', double amount = 0.0}) async {
    var approve;
    DeployedContract TokenContract =
        await WalletSwap().loadContract(tokenAdress: ERC20Address);
    var decimalsfunc = TokenContract.function('decimals');
    var senderAddress = Constants.ethereumAddress;
    final getDecimals = await ethClient.call(
        sender: senderAddress,
        contract: TokenContract,
        function: decimalsfunc,
        params: []);
    // log(get_decimals.first.toString());

    double requiredAmount = amount * math.pow(10, getDecimals[0].toInt());
    log(requiredAmount.toString());
    // log(exchange_amount.toString());
    var func = TokenContract.function("allowance");
    final getAllowance = await ethClient.call(
        sender: senderAddress,
        contract: TokenContract,
        function: func,
        params: [
          EthereumAddress.fromHex(Constants.address),
          EthereumAddress.fromHex(
              "0x7b5C526B7F8dfdff278b4a3e045083FBA4028790") //Allowing AAVE Pool Contract
        ]);
    int allowance = getAllowance[0].toInt();
    log(allowance.toString());
    if (allowance < requiredAmount) {
      // var func = Contract.function("approve");
      // approve = await ethClient.call(
      //     sender: senderAddress,
      //     contract: Contract,
      //     function: func,
      //     params: [
      //       EthereumAddress.fromHex(
      //           "0x7b5C526B7F8dfdff278b4a3e045083FBA4028790"),
      //       BigInt.from(requiredAmount)
      //     ]);
      // log(approve.toString());
      DeployedContract contract = await WalletSwap().loadContract(
          tokenAdress:
              "0xe9c4393a23246293a8D31BF7ab68c17d4CF90A29"); //Address of token to be lent
      var chainId = await ethClient.getChainId();
      var gasPrice = await ethClient.getGasPrice();
      var maxGas = await ethClient.estimateGas();
      try {
        var trans = await ethClient.sendTransaction(
            chainId: chainId.toInt(),
            Constants.userCredentials,
            Transaction.callContract(
                gasPrice: EtherAmount.inWei(BigInt.from(2000000000)),
                contract: contract,
                maxGas: 300000,
                function: contract.function("approve"),
                parameters: [
                  EthereumAddress.fromHex(
                      "0x7b5C526B7F8dfdff278b4a3e045083FBA4028790"), //Approving AAVE Contract
                  BigInt.from(requiredAmount),
                ]));
        // log(trans);
      } catch (e) {
        log(e.toString());
      }
    }
  }

  supply({String address = '', double amount = 0.0}) async {
    var approve = await approveERC20(ERC20Address: address, amount: amount);
    // var result = await callContract("supply", [
    //   EthereumAddress.fromHex(address),
    //   BigInt.from(amount),
    //   Constants.ethereumAddress,
    //   BigInt.from(0)
    // ]);
    DeployedContract contract = await loadContract();
    var chainId = await ethClient.getChainId();
    var gasPrice = await ethClient.getGasPrice();
    var maxGas = await ethClient.estimateGas();
    try {
      var trans = await ethClient.sendTransaction(
          chainId: chainId.toInt(),
          Constants.userCredentials,
          Transaction.callContract(
              gasPrice: EtherAmount.inWei(BigInt.from(2000000000)),
              contract: contract,
              maxGas: 300000,
              function: contract.function("supply"),
              parameters: [
                EthereumAddress.fromHex(
                    "0xe9c4393a23246293a8D31BF7ab68c17d4CF90A29"), //Token address of token to be lent
                BigInt.from(amount),
                Constants.ethereumAddress,
                BigInt.from(0)
              ]));
      log(trans);
    } catch (e) {
      log(e.toString());
    }
  }
}
