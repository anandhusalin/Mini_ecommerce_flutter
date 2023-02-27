import 'package:buttomy_application/common_widgets/container_custom.dart';
import 'package:buttomy_application/common_widgets/test_custom.dart';
import 'package:flutter/material.dart';

import '../core/constans/constants.dart';

class ButtonCustom extends StatelessWidget {
  final void Function()? buttonAction;
  final String buttonName;
  final MainAxisAlignment mainAxisAlignment;
  final double? width;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final IconData? icon;
  final double? textSize, iconSize;
  final bool loading;
  final String? image;
  const ButtonCustom({
    Key? key,
    required this.buttonName,
    this.borderColor,
    this.width,
    this.height,
    this.buttonAction,
    this.color,
    this.textSize,
    this.textColor,
    this.icon,
    required this.loading,
    this.image,
    required this.mainAxisAlignment,
    this.iconSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: const CircularProgressIndicator(),
      visible: !loading,
      child: SizedBox(
        width: width,
        height: height ?? 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          onPressed: buttonAction,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              image == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: ContainerCustom(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            image!,
                          )),
                    ),
              icon == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Icon(
                        size: (iconSize == null) ? 30 : iconSize,
                        icon,
                        color: Constants.whiteColor,
                      ),
                    ),
              Constants.width5,
              TextCustom(
                weight: FontWeight.bold,
                text1: buttonName,
                size: textSize ?? 20,
                colorOfText: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
