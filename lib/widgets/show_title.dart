import 'package:flutter/material.dart';
import 'package:nhongshoppingmall_1/utility/my_constant.dart';

class ShowTitle extends StatelessWidget {
  final String title;
  //final TextStyle textStyle; ==> Set1
  final TextStyle? textStyle;
  const ShowTitle({
    Key? key,
    required this.title,
    //required this.textStyle, ==> Set1
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      //style: textStyle, ==> Set1
      style: textStyle == null ? MyConstant().h3Style() : textStyle ,
    );
  }
}
