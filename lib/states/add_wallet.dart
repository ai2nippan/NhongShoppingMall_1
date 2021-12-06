import 'package:flutter/material.dart';
import 'package:nhongshoppingmall_1/bodys/bank.dart';
import 'package:nhongshoppingmall_1/bodys/credit.dart';
import 'package:nhongshoppingmall_1/bodys/promptpay.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  _AddWalletState createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  List<Widget> widgets = [
    Bank(),
    Promptpay(),
    Credit(),
  ];

  List<IconData> icons = [
    Icons.money,
    Icons.book,
    Icons.credit_card,
  ];

  List<String> titles = ['Bank', 'Promptpay', 'Credit'];

  int indexPosition = 0;

  List<BottomNavigationBarItem> bottomNavigationBarItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int i = 0;
    for (var item in titles) {
      bottomNavigationBarItems
          .add(createBottomNavigationBarItem(icons[i], item));
      i++;
    }
  }

  BottomNavigationBarItem createBottomNavigationBarItem(
          IconData iconData, String string) =>
      BottomNavigationBarItem(
        icon: Icon(iconData),
        label: string,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallet from ${titles[indexPosition]}'),
      ),
      body: widgets[indexPosition],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: MyConstant.dark,
        unselectedItemColor: MyConstant.light,
        // selectedIconTheme: IconThemeData(color: MyConstant.dark),
        // unselectedIconTheme: IconThemeData(color: MyConstant.light),
        items: bottomNavigationBarItems,
        currentIndex: indexPosition,
        onTap: (value) {
          setState(() {
            indexPosition = value;
          });
        },
      ),
    );
  }
}
