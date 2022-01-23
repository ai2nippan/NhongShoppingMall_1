import 'package:flutter/material.dart';
import 'package:nhongshoppingmall_1/models/wallet_model.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';
import 'package:nhongshoppingmall_1/widgets/show_list_wallet.dart';
import 'package:nhongshoppingmall_1/widgets/show_title.dart';

class Wait extends StatefulWidget {
  final List<WalletModel> walletModels;

  // const Wait({ Key? key }) : super(key: key);

  const Wait({Key? key, required this.walletModels}) : super(key: key);

  @override
  _WaitState createState() => _WaitState();
}

class _WaitState extends State<Wait> {
  List<WalletModel>? waitWalletModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitWalletModels = widget.walletModels;
    print('waitWallet ==> ${waitWalletModels!.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: waitWalletModels?.isEmpty ?? true
          ? Center(
              child: ShowTitle(
              title: 'No wait wallet',
              textStyle: MyConstant().h1RedStyle(),
            ))
          : ShowListWallet(walletModels: waitWalletModels),
    );
  }
}
