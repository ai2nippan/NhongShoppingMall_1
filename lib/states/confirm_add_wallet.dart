import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart'; masterung use
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';
import 'package:nhongshoppingmall_1/utility/my_dialog.dart';
import 'package:nhongshoppingmall_1/widgets/show_image.dart';
import 'package:nhongshoppingmall_1/widgets/show_title.dart';

class ConfirmAddWallet extends StatefulWidget {
  const ConfirmAddWallet({Key? key}) : super(key: key);

  @override
  _ConfirmAddWalletState createState() => _ConfirmAddWalletState();
}

class _ConfirmAddWalletState extends State<ConfirmAddWallet> {
  // late String
  //     dateTimeStr; //or String? dateTimeStr; (system will be permit null safety variable)

  // late File file;

  String? dateTimeStr;
  File? file;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findCurrentTime();
  }

  void findCurrentTime() {
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    //dateTimeStr = dateTime.toString();
    setState(() {
      dateTimeStr = dateFormat.format(dateTime);
    });
    print('dateTimeStr = $dateTimeStr');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Add Wallet'),
        leading: IconButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeBuyerService, (route) => false),
          icon: Platform.isIOS
              ? Icon(Icons.arrow_back_ios)
              : Icon(Icons.arrow_back),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              newHeader(),
              newDateTimePay(),
              Spacer(),
              newMoney(),
              Spacer(),
              newImage(),
              Spacer(),
              newButtonConfirm(),
            ],
          ),
        ),
      ),
    );
  }

  Row newMoney() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          child: TextFormField(keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill Money ?';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              label: ShowTitle(title: 'Money'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Container newButtonConfirm() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (file == null) {
              MyDialog().normalDialog(context, 'ยังไม่มีรูปภาพ',
                  'กรุณา ถ่ายภาพ หรือ ใช้ภาพจาก คลังภาพ');
            } else {
              processUploadAndInsertData();
            }
          }
        },
        child: Text('Confirm Add Wallet'),
      ),
    );
  }

  Future<void> processUploadAndInsertData() async {
    String apiSaveSlip =
        '${MyConstant.domain}/Mobile/Flutter2/Train/testapporder1/php/nhongshoppingmall_1/saveSlip.php';
    String nameSlip = 'slip${Random().nextInt(1000000)}.jpg';

    MyDialog().showProgressDialog(context);

    try {
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameSlip);

      FormData data = FormData.fromMap(map);
      await Dio().post(apiSaveSlip, data: data).then((value) {
        print('value ==> $value');
        Navigator.pop(context);
      });
    } catch (e) {}
  }

  Future<void> processTakePhoto(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row newImage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () => processTakePhoto(ImageSource.camera),
            icon: Icon(Icons.add_a_photo)),
        Container(
          width: 200,
          height: 200,
          child: file == null
              ? ShowImage(path: 'images/bill.png')
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => processTakePhoto(ImageSource.gallery),
          icon: Icon(Icons.add_photo_alternate),
        ),
      ],
    );
  }

  ShowTitle newDateTimePay() {
    return ShowTitle(
      title: dateTimeStr == null ? 'dd/MM/yy HH:mm' : dateTimeStr!,
      textStyle: MyConstant().h2BlueStyle(),
    );
  }

  ShowTitle newHeader() {
    return ShowTitle(
      title: 'Current Date Pay',
      textStyle: MyConstant().h1Style(),
    );
  }
}