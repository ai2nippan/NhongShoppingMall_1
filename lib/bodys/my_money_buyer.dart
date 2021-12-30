import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongshoppingmall_1/bodys/approve.dart';
import 'package:nhongshoppingmall_1/bodys/wait.dart';
import 'package:nhongshoppingmall_1/bodys/wallet.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMoneyBuyer extends StatefulWidget {
  const MyMoneyBuyer({Key? key}) : super(key: key);

  @override
  _MyMoneyBuyerState createState() => _MyMoneyBuyerState();
}

class _MyMoneyBuyerState extends State<MyMoneyBuyer> {
  int indexWidget = 0;
  var widgets = <Widget>[
    Wallet(),
    Approve(),
    Wait(),
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
      print('value ===>> $value');
    });
  }

  void setupBottomBar() {
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
      body: widgets[indexWidget],
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
