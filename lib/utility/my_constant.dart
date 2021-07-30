import 'package:flutter/material.dart';

class MyConstant {
  
  // General 
  static String appName = 'Shopping Mall';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeBuyerService = 'buyerService';
  static String routeSalerService = 'salerService';
  static String routeRiderService = 'riderService';


  // Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';

  // Color
  static Color primary = Color(0xff87861d); // Background, Bar
  static Color dark = Color(0xff575900); // font color
  static Color light = Color(0xffb9b64e); // focus color

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

  // body part ส่วนของ body ธรรมดา
  TextStyle h3Style() => TextStyle(
    fontSize: 14,
    color: dark,
    fontWeight: FontWeight.normal,
  );
}