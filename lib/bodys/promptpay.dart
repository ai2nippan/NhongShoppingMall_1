import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';
import 'package:nhongshoppingmall_1/utility/my_dialog.dart';
import 'package:nhongshoppingmall_1/widgets/nav_confirm_add_wallet.dart';
import 'package:nhongshoppingmall_1/widgets/show_progress.dart';
import 'package:nhongshoppingmall_1/widgets/show_title.dart';

class Promptpay extends StatefulWidget {
  const Promptpay({Key? key}) : super(key: key);

  @override
  _PromptpayState createState() => _PromptpayState();
}

class _PromptpayState extends State<Promptpay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTitle(),
            buildCopyPromptpay(),
            buildQRcodePromptpay(),
            buildDownload(),
          ],
        ),
      ),floatingActionButton: NavConfirmAddWallet(),
    );
  }

  ElevatedButton buildDownload() => ElevatedButton(
        onPressed: () async {
          String path = '/sdcard/download';
          try {
            await FileUtils.mkdir([path]);
            await Dio()
                .download(MyConstant.urlPromptpay, '$path/promptpay.png')
                .then((value) => MyDialog().normalDialog(
                    context,
                    'Download Promptpay Finish',
                    'กรุณาไปที่แอพธนาคาร เพื่ออ่าน QR code ที่โหลดมา'));
          } catch (e) {
            print('## error ==> ${e.toString()}');
            MyDialog().normalDialog(context, 'Storage Permission Denied', 'กรุณาเปิด Permission Storage ด้วยคะ');
          }
        },
        child: Text('Download QRcode'),
      );

  Container buildQRcodePromptpay() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: CachedNetworkImage(
          imageUrl: MyConstant.urlPromptpay,
          placeholder: (context, url) => ShowProgress(),
        ));
  }

  Widget buildCopyPromptpay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: Colors.lime.shade100,
        child: ListTile(
          title: ShowTitle(
            title: '081-859-5309',
            textStyle: MyConstant().h1Style(),
          ),
          subtitle: ShowTitle(title: 'บัญชี Promptpay'),
          trailing: IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: '0818595309'));
                MyDialog().normalDialog(context, 'Copy Promptpay',
                    'Copy Promptpay to Clipboard สำเร็จ แล้ว กรุณาไปที่ แอพธนาคาร ท่าน เพื่อโอนเงิน ผ่าน Promptpay ได้เลย คะ');
              },
              icon: Icon(
                Icons.copy,
                color: MyConstant.dark,
              )),
        ),
      ),
    );
  }

  ShowTitle buildTitle() {
    return ShowTitle(
      title: 'การโอนเงินโดยใช้ Promptpay',
      textStyle: MyConstant().h2Style(),
    );
  }
}
