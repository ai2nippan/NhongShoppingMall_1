import 'package:flutter/material.dart';
import 'package:nhongshoppingmall_1/states/add_product.dart';
import 'package:nhongshoppingmall_1/states/add_wallet.dart';
import 'package:nhongshoppingmall_1/states/authen.dart';
import 'package:nhongshoppingmall_1/states/buyer_service.dart';
import 'package:nhongshoppingmall_1/states/confirm_add_wallet.dart';
import 'package:nhongshoppingmall_1/states/create_account.dart';
import 'package:nhongshoppingmall_1/states/edit_profile_saler.dart';
import 'package:nhongshoppingmall_1/states/rider_service.dart';
import 'package:nhongshoppingmall_1/states/saler_service.dart';
import 'package:nhongshoppingmall_1/states/show_cart.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/salerService': (BuildContext context) => SalerService(),
  '/riderService': (BuildContext context) => RiderService(),
  '/addProduct': (BuildContext context) => AddProduct(),
  '/editProfileSaler': (BuildContext context) => EditProfileSaler(),
  // '/showCart': (BuildContext context) => ShowCart(),
  // '/addWallet': (BuildContext context)=> AddWallet(),
  MyConstant.routeShowCart: (BuildContext context) => ShowCart(),
  MyConstant.routeAddWallet :(BuildContext context)=> AddWallet(),
  MyConstant.routeConfirmAddWallet : (BuildContext context)=> ConfirmAddWallet(),
};

String? initlalRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initlalRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'buyer':
        initlalRoute = MyConstant.routeBuyerService;
        runApp(MyApp());
        break;
      case 'seller':
        initlalRoute = MyConstant.routeSalerService;
        runApp(MyApp());
        break;
      case 'rider':
        initlalRoute = MyConstant.routeRiderService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

// void main(){
//   initlalRoute = MyConstant.routeAuthen;
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor =
        MaterialColor(0xff575900, MyConstant.mapMaterialColor);
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
      //theme: ThemeData(primarySwatch: Colors.purple),
      //theme: ThemeData(primarySwatch: MyConstant.dark), // can not do
      theme: ThemeData(primarySwatch: materialColor),
    );
  }
}
