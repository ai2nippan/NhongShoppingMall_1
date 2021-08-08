import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(//backgroundColor: Colors.purple,
        title: Text('Buyer'),
      ),
      drawer: Drawer(
        //child: buildSignOut(),
        child: ShowSignOut(),
      ),
    );
  }


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
