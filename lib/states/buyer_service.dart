import 'package:flutter/material.dart';
import 'package:nhongshoppingmall_1/bodys/my_money_buyer.dart';
import 'package:nhongshoppingmall_1/bodys/my_order_buyer.dart';
import 'package:nhongshoppingmall_1/bodys/show_all_shop_buyer.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';
import 'package:nhongshoppingmall_1/widgets/show_signout.dart';
import 'package:nhongshoppingmall_1/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({Key? key}) : super(key: key);

  @override
  _BuyerServiceState createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  List<Widget> widgets = [
    ShowAllShopBuyer(),
    MyMoneyBuyer(),
    MyOrderBuyer(),
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.purple,
        title: Text('Buyer'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, MyConstant.routeShowCart),
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        //child: buildSignOut(),
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(),
                menuShowAllShop(),
                menuMyMoney(),
                menuMyOrder(),
              ],
            ),
            ShowSignOut(),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }

  ListTile menuShowAllShop() {
    return ListTile(
      leading: Icon(
        Icons.shopping_bag_outlined,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'Show All Shop',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงร้านค้า ทั้งหมด',
        textStyle: MyConstant().h3Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyMoney() {
    return ListTile(
      leading: Icon(
        Icons.money,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'My Money',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงจำนวนเงิน ที่มี',
        textStyle: MyConstant().h3Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyOrder() {
    return ListTile(
      leading: Icon(
        Icons.list,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(
        title: 'MyOrder',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
        title: 'แสดงรายการสั่งของ',
        textStyle: MyConstant().h3Style(),
      ),
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
    );
  }

  UserAccountsDrawerHeader buildHeader() =>
      UserAccountsDrawerHeader(accountName: null, accountEmail: null);

  // Cancel in here and move to new file : show_signout.dart
  // Column buildSignOut() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       ListTile(
  //         onTap: () async {
  //           SharedPreferences preferences =
  //               await SharedPreferences.getInstance();
  //           preferences.clear().then(
  //                 (value) => Navigator.pushNamedAndRemoveUntil(
  //                     context, MyConstant.routeAuthen, (route) => false),
  //               );
  //         },
  //         tileColor: Colors.red.shade900,
  //         leading: Icon(
  //           Icons.exit_to_app,
  //           size: 36,
  //           color: Colors.white,
  //         ),
  //         title: ShowTitle(
  //           title: 'Sign Out',
  //           textStyle: MyConstant().h2WhiteStyle(),
  //         ),
  //         subtitle: ShowTitle(
  //           title: 'Sign Out And Go to Authen',
  //           textStyle: MyConstant().h3WhiteStyle(),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
