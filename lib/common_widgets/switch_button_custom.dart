import 'package:buttomy_application/common_widgets/test_custom.dart';
import 'package:buttomy_application/core/constans/constants.dart';
import 'package:flutter/material.dart';

class SwitchButtonCustom extends StatelessWidget {
  final String text;
  final bool val;
  final void Function(bool)? function;
  const SwitchButtonCustom(
      {super.key,
      required this.text,
      required this.val,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextCustom(text1: text),
        Switch.adaptive(
          value: val,
          activeColor: Constants.blueColor,
          onChanged: function,
        )
      ],
    );
  }
}
