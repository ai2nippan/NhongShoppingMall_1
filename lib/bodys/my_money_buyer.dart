import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongshoppingmall_1/bodys/approve.dart';
import 'package:nhongshoppingmall_1/bodys/wait.dart';
import 'package:nhongshoppingmall_1/bodys/wallet.dart';
import 'package:nhongshoppingmall_1/models/wallet_model.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';
import 'package:nhongshoppingmall_1/widgets/show_no_data.dart';
import 'package:nhongshoppingmall_1/widgets/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMoneyBuyer extends StatefulWidget {
  const MyMoneyBuyer({Key? key}) : super(key: key);

  @override
  _MyMoneyBuyerState createState() => _MyMoneyBuyerState();
}

class _MyMoneyBuyerState extends State<MyMoneyBuyer> {
  int indexWidget = 0;
  var widgets = <Widget>[
    // Wallet(),
    // Approve(),
    // Wait(),
  ];

  var titles = <String>[
    'Wallet',
    'Approve',
    'Wait',
  ];

  var iconDatas = <IconData>[
    Icons.money,
    Icons.fact_check,
    Icons.hourglass_bottom,
  ];

  var bottomNavigationBarItems = <BottomNavigationBarItem>[];

  int approvedWallet = 0, waitApproveWallet = 0;

  bool load = true;
  bool? havewallet;

  // Declare list walletModel have 2 method.
  // List<WalletModel> approveWalletModels = [];
  var approveWalletModels = <WalletModel>[];

  var waitWalletModels = <WalletModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllWallet();
    setupBottomBar();
  }

  Future<void> readAllWallet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idBuyer = preferences.getString('id');
    print('idBuyer ==> $idBuyer');

    var path =
        '${MyConstant.domain}/Mobile/Flutter2/Train/testapporder1/php/nhongshoppingmall_1/getWalletWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer';
    await Dio().get(path).then((value) {
      print('### value getwalletWhereIdBuyer ===>> $value');

      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          WalletModel model = WalletModel.fromMap(item);
          switch (model.status) {
            case 'Approve':
              approvedWallet = approvedWallet + int.parse(model.money);
              approveWalletModels.add(model);
              break;
            case 'WaitOrder':
              waitApproveWallet = waitApproveWallet + int.parse(model.money);
              waitWalletModels.add(model);
              break;
            default:
          }
        }

        print(
            'approveWallet ===>> $approvedWallet, waitApprove = $waitApproveWallet');

        widgets.add(Wallet(
          approveWallet: approvedWallet,
          waitApproveWallet: waitApproveWallet,
        ));
        widgets.add(Approve(
          walletModels: approveWalletModels,
        ));
        widgets.add(Wait(
          walletModels: waitWalletModels,
        ));

        setState(() {
          load = false;
          havewallet = true;
        });
        
      } else {
        print('### no wallet Status');

        setState(() {
          load = false;
          havewallet = false;
        });
      }
    });
  }

  void setupBottomBar() {
    // widgets.add(Wallet());
    // widgets.add(Approve());
    // widgets.add(Wait());

    int index = 0;
    for (var title in titles) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
          label: title,
          icon: Icon(
            iconDatas[index],
          ),
        ),
      );
      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load ? ShowProgress() : havewallet!  ? widgets[indexWidget] : ShowNoData(title: 'No Wallet', pathImage: 'images/image4.png') ,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: MyConstant.light,
        selectedItemColor: MyConstant.dark,
        onTap: (value) {
          setState(() {
            indexWidget = value;
          });
        },
        currentIndex: indexWidget,
        items: bottomNavigationBarItems,
      ),
    );
  }
}
