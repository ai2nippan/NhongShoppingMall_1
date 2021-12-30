import 'package:flutter/material.dart';

class MyConstant {
  // General
  static String appName = 'Shopping Mall';
  //static String domain = 'https://40f8a147d35c.ngrok.io';
  //static String domain = 'http://edd0-223-24-154-37.ngrok.io';
  static String domain = 'http://192.168.1.111';

  static String urlPromptpay = 'https://promptpay.io/0891689969.png';

  // Omise
  static String publicKey = 'pkey_test_5psx6grvba1wp015hdb';
  static String secretKey = 'skey_test_5psx6grvlb3i4k16mar';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = '/buyerService';
  static String routeSalerService = '/salerService';
  static String routeRiderService = '/riderService';
  static String routeAddProduct = '/addProduct';
  static String routeEditProfileSaler = '/editProfileSaler';
  static String routeShowCart = '/showCart';
  static String routeAddWallet = '/addWallet';
  static String routeConfirmAddWallet = '/confirmAddWallet';

  // Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String image5 = 'images/image5.png';
  static String avatar = 'images/avatar.png';

  // Color
  static Color primary = Color(0xff87861d); // Background, Bar
  static Color dark = Color(0xff575900); // font color
  static Color light = Color(0xffb9b64e); // focus color
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(255, 87, 89, 0.1),
    100: Color.fromRGBO(255, 87, 89, 0.2),
    200: Color.fromRGBO(255, 87, 89, 0.3),
    300: Color.fromRGBO(255, 87, 89, 0.4),
    400: Color.fromRGBO(255, 87, 89, 0.5),
    500: Color.fromRGBO(255, 87, 89, 0.6),
    600: Color.fromRGBO(255, 87, 89, 0.7),
    700: Color.fromRGBO(255, 87, 89, 0.8),
    800: Color.fromRGBO(255, 87, 89, 0.9),
    900: Color.fromRGBO(255, 87, 89, 1.0),
  };

  // Background
  BoxDecoration planBackground() =>
      BoxDecoration(color: MyConstant.light.withOpacity(0.75));

  BoxDecoration whiteBackground() => BoxDecoration(
        color: Colors.white,
      );

  // Background Gradient
  // Left -> Right (Default)
  BoxDecoration gradientLinearBackground() => BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, MyConstant.primary],
        ),
      );

  BoxDecoration gradientLinearTopDownBackground() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          //colors: [Colors.white, MyConstant.primary,MyConstant.dark],
          colors: [Colors.white, MyConstant.light, MyConstant.primary],
        ),
      );

  // Radial Gradient
  BoxDecoration gradientRadioBackground() => BoxDecoration(
        gradient: RadialGradient(
          //center: Alignment.topCenter,
          center: Alignment(0, -0.5),
          radius: 1.5,  //0.5 //default,
          colors: [Colors.white, MyConstant.primary],
          //colors: [Colors.white, MyConstant.light,MyConstant.primary],
        ),
      );

  // Style

  // Big Font ตัวใหญ่
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  // หัวข้อ
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700, // w70%
      );

  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700, // w70%
      );

  TextStyle h2RedStyle() => TextStyle(
        fontSize: 18,
        color: Colors.red.shade700,
        fontWeight: FontWeight.w700, // w70%
      );

  TextStyle h2BlueStyle() => TextStyle(
        fontSize: 18,
        color: Colors.blue.shade800,
        fontWeight: FontWeight.w700, // w70%
      );

  // body part ส่วนของ body ธรรมดา
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  // Button Style

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
