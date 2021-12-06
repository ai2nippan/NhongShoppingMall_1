import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';
import 'package:nhongshoppingmall_1/utility/my_dialog.dart';
import 'package:nhongshoppingmall_1/widgets/show_title.dart';
import 'package:omise_flutter/omise_flutter.dart';

import 'package:http/http.dart' as http;

class Credit extends StatefulWidget {
  const Credit({Key? key}) : super(key: key);

  @override
  _CreditState createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  String? name,
      surname,
      idCard,
      expiryDateMonth,
      expiryDateYear,
      cvc,
      amount,
      expiryDateStr;
  MaskTextInputFormatter idCardMask =
      MaskTextInputFormatter(mask: '#### - #### - #### - ####');

  MaskTextInputFormatter expiryDateMask =
      MaskTextInputFormatter(mask: '## / ####');

  MaskTextInputFormatter cvcMask = MaskTextInputFormatter(mask: '###');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle('Name Surname'),
                    buildNameSurname(),
                    buildTitle('ID Card'),
                    formIDcard(),
                    buildExpiryCvc(),
                    buildTitle('Amount :'),
                    formAmount(),
                    SizedBox(
                      height: 100,
                    ),
                    // Spacer(),
                    //buildAddMoney(),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildAddMoney(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildAddMoney() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // expriryDateMonth = expiryDateStr!.substring(0, 2);
            // expiryDateYear = expiryDateStr!.substring(2, 6);

            getTokenAndChargeOmise();
          }
        },
        child: Text('Add Money'),
      ),
    );
  }

  Future<void> getTokenAndChargeOmise() async {
    String publicKey = MyConstant.publicKey;

    print(
        'name = $name, surname = $surname, Omise publicKey = $publicKey, value ===>> $idCard, expiryDateStr = $expiryDateStr, expiryDateMonth ===>> $expiryDateMonth, expiryDateYear ===>> $expiryDateYear, cvc ==> $cvc');

    OmiseFlutter omiseFlutter = OmiseFlutter(publicKey);
    await omiseFlutter.token
        .create(
            '$name $surname', idCard!, expiryDateMonth!, expiryDateYear!, cvc!)
        .then((value) async {
      //return null;
      String token = value.id.toString();
      print('token ===>> $token');

      String secretKey = MyConstant.secretKey;
      String urlAPI = 'https://api.omise.co/charges';
      String basicAuth = 'Basic ' + base64Encode(utf8.encode(secretKey + ":"));

      Map<String, String> headerMap = {};
      headerMap['authorization'] = basicAuth;
      headerMap['Cache-Control'] = 'no-cache';
      headerMap['Content-Type'] = 'application/x-www-form-urlencoded';

      String zero = '00';
      amount = '$amount$zero';
      print('amount00 ===>>> $amount');

      Map<String, dynamic> data = {};
      data['amount'] = amount;
      data['currency'] = 'thb';
      data['card'] = token;

      Uri uri = Uri.parse(urlAPI);

      http.Response response = await http.post(
        uri,
        headers: headerMap,
        body: data,
      );

      var resultCharge = json.decode(response.body);

      //print('resultCharge = $resultCharge');
      print('status ของการตัดบัตร --->>> ${resultCharge['status']}');

    }).catchError((value) {
      String title = value.code;
      String message = value.message;
      MyDialog().normalDialog(context, title, message);
    });
  }

  Widget formAmount() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill Amount in Blank';
            } else {
              amount = value.trim();
              return null;
            }
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffix: ShowTitle(
              title: 'THB',
              textStyle: MyConstant().h2RedStyle(),
            ),
            labelText: 'Amount :',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

  Container buildExpiryCvc() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          buildSizeBox(30),
          Expanded(
            child: Column(
              children: [
                buildTitle('Expiry Date :'),
                formExpiryDate(),
              ],
            ),
          ),
          buildSizeBox(8),
          Expanded(
            child: Column(
              children: [
                buildTitle('CVC :'),
                formCVC(),
              ],
            ),
          ),
          buildSizeBox(30),
        ],
      ),
    );
  }

  Widget formExpiryDate() => TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Expiry in Blank';
          } else {
            //return null;
            if (expiryDateStr!.length != 6) {
              return 'กรุณา กรอกให้ครบ';
            } else {
              //return null;
              expiryDateMonth = expiryDateStr!.substring(0, 2);
              expiryDateYear = expiryDateStr!.substring(2, 6);

              int expiryDateMonthInt = int.parse(expiryDateMonth!);
              expiryDateMonth = expiryDateMonthInt.toString();

              if (expiryDateMonthInt > 12) {
                return 'เดือนไม่ควรเกิน 12';
              } else {
                return null;
              }
            }
          }
        },
        onChanged: (value) {
          expiryDateStr = expiryDateMask.getUnmaskedText();
          //String expiryDateStr = expiryDateMask.getUnmaskedText();
          // expriryDateMonth = expiryDateStr.substring(0,1);
          // expiryDateYear = expiryDateStr.substring(2,5);
        },
        inputFormatters: [expiryDateMask],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xx/xxxx',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );

  Widget formCVC() => TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill CVC in Blank';
          } else {
            //return null;
            if (cvc!.length != 3) {
              return 'cvc ต้องมี 3 ตัว';
            } else {}
          }
        },
        onChanged: (value) {
          cvc = cvcMask.getUnmaskedText();
        },
        inputFormatters: [cvcMask],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xxx',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );

  Container buildNameSurname() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          buildSizeBox(30),
          formName(),
          buildSizeBox(8),
          formSurName(),
          buildSizeBox(30),
        ],
      ),
    );
  }

  SizedBox buildSizeBox(double width) => SizedBox(
        width: width,
      );

  Widget formIDcard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill ID Card in Blank';
            } else {
              //return null;
              if (idCard!.length != 16) {
                return 'ID Card ต้องมี 16 ตัวอักษร คะ';
              } else {
                return null;
              }
            }
          },
          inputFormatters: [idCardMask],
          onChanged: (value) {
            // idCard = value.trim();
            idCard = idCardMask.getUnmaskedText();
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'xxxx-xxxx-xxxx-xxxx',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );

  Widget formName() => Expanded(
          child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Name in Blank';
          } else {
            name = value.trim();
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Name :',
          hintText: 'Name :',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ));

  Widget formSurName() => Expanded(
          child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Surname in Blank';
          } else {
            surname = value.trim();
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Surname :',
          hintText: 'Surname :',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ));

  // Padding or Widget OK
  Widget buildTitle(String title) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ShowTitle(
          title: title,
          textStyle: MyConstant().h2BlueStyle(),
        ),
      );
}
