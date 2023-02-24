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
  Future<DeployedContract> loadAAVEContract() async {
    String abi =
        await rootBundle.loadString("contracts/lend_borrow_contract.json");
    final contract = DeployedContract(
        ContractAbi.fromJson(abi, "Aave Pool"),
        EthereumAddress.fromHex(
            "0x7b5C526B7F8dfdff278b4a3e045083FBA4028790")); //AAVE Pool Contract
    return contract;
  }

  Future<List<dynamic>> callContract(
      {required String funcName,
      required List<dynamic> args,
      required DeployedContract contract}) async {
    var _contract = contract;
    var func = _contract.function(funcName);
    var result = await ethClient.call(
        sender: Constants.ethereumAddress,
        contract: _contract,
        function: func,
        params: args);
    return result;
  }

  Future<List<dynamic>> callContractData({
    required String funcName,
  }) async {
    var contract = await loadAAVEContract();
    var func = contract.function(funcName);
    var result = await ethClient.call(
        sender: Constants.ethereumAddress,
        contract: contract,
        function: func,
        params: []);
    return result;
  }

  approveERC20(
      {String ERC20Address = '',
      String addressToApprove = '',
      double amount = 0.0}) async {
    var approve;
    DeployedContract TokenContract = await WalletSwap().loadContract(
        tokenAdress: ERC20Address, contractFileName: "test_net_erc");
    var decimalsfunc = TokenContract.function('decimals');
    var senderAddress = Constants.ethereumAddress;
    final getDecimals = await ethClient.call(
        sender: senderAddress,
        contract: TokenContract,
        function: decimalsfunc,
        params: []);

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
      DeployedContract contract = await WalletSwap().loadContract(
          contractFileName: "test_net_erc",
          tokenAdress: ERC20Address); //Address of token to be lent
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
                      addressToApprove), //Approving AAVE Contract
                  BigInt.from(requiredAmount),
                ]));
      } catch (e) {
        log(e.toString());
      }
    }
  }

  supply({String address = '', double amount = 0.0}) async {
    if (address == "0x0000000000000000000000000000000000000000") {
      DeployedContract gatewayContract = await WalletSwap().loadContract(
          contractFileName: "WrappedTokenGatewayV3",
          tokenAdress: "0x2A498323aCaD2971a8b1936fD7540596dC9BBacD");
      var chainId = await ethClient.getChainId();
      var gasPrice = await ethClient.getGasPrice();
      var maxGas = await ethClient.estimateGas();
      try {
        var trans = await ethClient.sendTransaction(
            chainId: chainId.toInt(),
            Constants.userCredentials,
            Transaction.callContract(
                value: EtherAmount.fromInt(EtherUnit.wei, amount.toInt()),
                gasPrice: EtherAmount.inWei(BigInt.from(2000000000)),
                contract: gatewayContract,
                maxGas: 300000,
                function: gatewayContract.function("depositETH"),
                parameters: [
                  EthereumAddress.fromHex(
                      "0x7b5C526B7F8dfdff278b4a3e045083FBA4028790"),
                  Constants.ethereumAddress,
                  BigInt.zero
                ]));
        log(trans);
      } catch (e) {
        log(e.toString());
      }
    } else {
      var approve = await approveERC20(
          ERC20Address: address,
          amount: amount,
          addressToApprove: "0x7b5C526B7F8dfdff278b4a3e045083FBA4028790");
      DeployedContract contract = await loadAAVEContract();
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
                      address), //Token address of token to be lent
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

  getUserData({required EthereumAddress UserAddress}) async {
    // var userData =
    //     await callContract(funcName: "getUserAccountData", args: [UserAddress]);
    // return userData;
  }

  withdraw(
      {String ERC20address = '',
      double amount = 0.0,
      bool unwrap = false}) async {
    if (ERC20address != "0xCCB14936C2E000ED8393A571D15A2672537838Ad") {
      DeployedContract contract = await loadAAVEContract();
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
                function: contract.function("withdraw"),
                parameters: [
                  EthereumAddress.fromHex(
                      ERC20address), //Token address of token to be lent
                  BigInt.from(amount),
                  Constants.ethereumAddress,
                ]));
        log(trans);
      } catch (e) {
        log(e.toString());
      }
    } else {
      if (!unwrap) {
        DeployedContract contract = await loadAAVEContract();
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
                  function: contract.function("withdraw"),
                  parameters: [
                    EthereumAddress.fromHex(
                        ERC20address), //Token address of token to be lent
                    BigInt.from(amount),
                    Constants.ethereumAddress,
                  ]));
          log(trans);
        } catch (e) {
          log(e.toString());
        }
      } else {
        DeployedContract contract = await WalletSwap().loadContract(
            contractFileName: "WrappedTokenGatewayV3",
            tokenAdress: "0x2A498323aCaD2971a8b1936fD7540596dC9BBacD");
        var approve = await approveERC20(
            ERC20Address: "0x7649e0d153752c556b8b23DB1f1D3d42993E83a5",
            amount: amount,
            addressToApprove: "0x2A498323aCaD2971a8b1936fD7540596dC9BBacD");
        try {
          var chainId = await ethClient.getChainId();
          var gasPrice = await ethClient.getGasPrice();
          var maxGas = await ethClient.estimateGas();
          var trans = await ethClient.sendTransaction(
              chainId: chainId.toInt(),
              Constants.userCredentials,
              Transaction.callContract(
                  gasPrice: EtherAmount.inWei(BigInt.from(2000000000)),
                  contract: contract,
                  maxGas: 300000,
                  function: contract.function("withdrawETH"),
                  parameters: [
                    EthereumAddress.fromHex(
                        "0x7b5c526b7f8dfdff278b4a3e045083fba4028790"), //Token address of token to be lent
                    BigInt.from(amount),
                    Constants.ethereumAddress,
                  ]));
          log(trans);
        } catch (e) {
          log(e.toString());
        }
      }
    }
  }

  borrow(
      {String ERC20address = '',
      double amount = 0.0,
      bool unwrap = false}) async {
    if (ERC20address != "0xCCB14936C2E000ED8393A571D15A2672537838Ad") {
      DeployedContract contract = await loadAAVEContract();
      var chainId = await ethClient.getChainId();
      var gasPrice = await ethClient.getGasPrice();
      var maxGas = await ethClient.estimateGas();
      // var tokenData = await getTokenData();
      // log(tokenData[0].toString());
      var Amount = EtherAmount.fromInt(EtherUnit.wei, amount.toInt()).getInWei;
      try {
        var trans = await ethClient.sendTransaction(
            chainId: chainId.toInt(),
            Constants.userCredentials,
            Transaction.callContract(
                gasPrice: gasPrice,
                contract: contract,
                maxGas: 300000,
                function: contract.function("borrow"),
                parameters: [
                  EthereumAddress.fromHex(
                      ERC20address), //Token address of token to be lent
                  BigInt.from(Amount.toInt()),
                  BigInt.two,
                  BigInt.zero,
                  Constants.ethereumAddress,
                ]));
        log(trans);
      } catch (e) {
        log(e.toString());
      }
    } else {
      if (!unwrap) {
        DeployedContract contract = await loadAAVEContract();
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
                  function: contract.function("borrow"),
                  parameters: [
                    EthereumAddress.fromHex(
                        ERC20address), //Token address of token to be lent
                    BigInt.from(amount),
                    Constants.ethereumAddress,
                  ]));
          log(trans);
        } catch (e) {
          log(e.toString());
        }
      } else {
        DeployedContract approveContract = await WalletSwap().loadContract(
            contractFileName: "VariableDebtToken",
            tokenAdress: "0xff3284be0c687c21ccb18a8e61a27aec72c520bc");
        var chainId = await ethClient.getChainId();
        var gasPrice = await ethClient.getGasPrice();
        var maxGas = await ethClient.estimateGas();
        try {
          var trans = await ethClient.sendTransaction(
              chainId: chainId.toInt(),
              Constants.userCredentials,
              Transaction.callContract(
                  gasPrice: EtherAmount.inWei(BigInt.from(2000000000)),
                  contract: approveContract,
                  maxGas: 300000,
                  function: approveContract.function("approveDelegation"),
                  parameters: [
                    EthereumAddress.fromHex(
                        "0x2A498323aCaD2971a8b1936fD7540596dC9BBacD"),
                    BigInt.from(amount),
                  ]));
          log(trans);
        } catch (e) {
          log(e.toString());
        }
        DeployedContract gatewayContract = await WalletSwap().loadContract(
            contractFileName: "WrappedTokenGatewayV3",
            tokenAdress: "0x2A498323aCaD2971a8b1936fD7540596dC9BBacD");
        try {
          var trans = await ethClient.sendTransaction(
              chainId: chainId.toInt(),
              Constants.userCredentials,
              Transaction.callContract(
                  gasPrice: EtherAmount.inWei(BigInt.from(2000000000)),
                  contract: gatewayContract,
                  maxGas: 300000,
                  function: gatewayContract.function("borrowETH"),
                  parameters: [
                    EthereumAddress.fromHex(
                        "0x7b5C526B7F8dfdff278b4a3e045083FBA4028790"),
                    BigInt.from(amount),
                    BigInt.two,
                    BigInt.zero
                  ]));
          log(trans);
        } catch (e) {
          log(e.toString());
        }
      }
    }
    // DeployedContract contract = await loadAAVEContract();
    // var chainId = await ethClient.getChainId();
    // var gasPrice = await ethClient.getGasPrice();
    // var maxGas = await ethClient.estimateGas();
    // try {
    //   var trans = await ethClient.sendTransaction(
    //       chainId: chainId.toInt(),
    //       Constants.userCredentials,
    //       Transaction.callContract(
    //           gasPrice: EtherAmount.inWei(BigInt.from(2000000000)),
    //           contract: contract,
    //           maxGas: 300000,
    //           function: contract.function("borrow"),
    //           parameters: [
    //             EthereumAddress.fromHex(
    //                 ERC20address), //Token address of token to be lent
    //             BigInt.from(amount),
    //             BigInt.two,
    //             BigInt.zero,
    //             Constants.ethereumAddress,
    //           ]));
    //   log(trans);
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  repay(
      {String ERC20address = '',
      double amount = 0.0,
      int repayType = 0}) async {
    if (repayType == 0) {
      var approve = await approveERC20(
          ERC20Address: ERC20address,
          amount: amount,
          addressToApprove: "0x7b5C526B7F8dfdff278b4a3e045083FBA4028790");
      DeployedContract contract = await loadAAVEContract();
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
                function: contract.function("repay"),
                parameters: [
                  EthereumAddress.fromHex(
                      ERC20address), //Token address of token to be lent
                  BigInt.from(amount),
                  BigInt.two,
                  Constants.ethereumAddress,
                ]));
        log(trans);
      } catch (e) {
        log(e.toString());
      }
    } else if (repayType == 1) {
      DeployedContract contract = await loadAAVEContract();
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
                function: contract.function("repayWithATokens"),
                parameters: [
                  EthereumAddress.fromHex(
                      ERC20address), //Token address of token to be lent
                  BigInt.from(amount),
                  BigInt.two,
                ]));
        log(trans);
      } catch (e) {
        log(e.toString());
      }
    } else if (repayType == 2 &&
        (ERC20address == "0x0000000000000000000000000000000000000000" ||
            ERC20address == "0xCCB14936C2E000ED8393A571D15A2672537838Ad")) {
      DeployedContract gatewayContract = await WalletSwap().loadContract(
          contractFileName: "WrappedTokenGatewayV3",
          tokenAdress: "0x2A498323aCaD2971a8b1936fD7540596dC9BBacD");
      var chainId = await ethClient.getChainId();
      var gasPrice = await ethClient.getGasPrice();
      var maxGas = await ethClient.estimateGas();
      try {
        var trans = await ethClient.sendTransaction(
            chainId: chainId.toInt(),
            Constants.userCredentials,
            Transaction.callContract(
                value: EtherAmount.fromInt(EtherUnit.wei, amount.toInt()),
                gasPrice: EtherAmount.inWei(BigInt.from(2000000000)),
                contract: gatewayContract,
                maxGas: 300000,
                function: gatewayContract.function("repayETH"),
                parameters: [
                  EthereumAddress.fromHex(
                      "0x7b5C526B7F8dfdff278b4a3e045083FBA4028790"),
                  BigInt.from(amount),
                  BigInt.two,
                  Constants.ethereumAddress
                ]));
        log(trans);
      } catch (e) {
        log(e.toString());
      }
    }
  }

  getTokenData() async {
    var contract = await WalletSwap().loadContract(
        contractFileName: "AaveProtocolDataProvider",
        tokenAdress: "0xa41E284482F9923E265832bE59627d91432da76C");
    var userData = await callContract(
      funcName: "getAllReservesTokens",
      args: [],
      contract: contract,
    );
    // log(userData.toString());
    List<dynamic> data1 = [];
    List<dynamic> data2 = [];
    List<dynamic> data3 = [];
    Map<dynamic, Map> tokenData = {};
    var _data;
    int i = 0;
    for (_data in userData[0]) {
      data2.add(await callContract(
          funcName: "getReserveConfigurationData",
          args: [EthereumAddress.fromHex(_data[1].toString())],
          contract: contract));
      data1.add(await callContract(
          funcName: "getReserveData",
          args: [EthereumAddress.fromHex(_data[1].toString())],
          contract: contract));
      data3.add(await callContract(
          funcName: "getUserReserveData",
          args: [
            EthereumAddress.fromHex(_data[1].toString()),
            Constants.ethereumAddress
          ],
          contract: contract));
      tokenData.addEntries([
        MapEntry(_data[1].toString(), {
          "decimals": data2[i][0],
          "ltv": data2[i][1],
          "CollateralEnabled": data2[i][5],
          "BorrowEnabled": data2[i][6],
          "isActive": data2[i][7],
          "isFrozen": data2[i][8],
          "variableBorrowRate": data1[i][6],
          "variableBorrowIndex": data1[i][10],
          "currentVariableDebt": data3[i][3],
          "aTokenbalance": data3[i][0],
          "usageAsCollateralEnabled": data3[i][0]
        })
      ]);
      i++;
    }
    // log(tokenData.toString());
    return tokenData;
    // log(data1.toString());
    // log(data2.toString());
    // log(data3.toString());
  }
}
