import 'package:flutter/material.dart';
import '../core/constans/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final String? secondTitle;
  final IconData? icon;
  final Widget? actionWidget;
  final void Function()? appbarleadingFunction;

  const CustomAppBar({
    this.actionWidget,
    this.icon,
    Key? key,
    required this.title,
    this.appbarleadingFunction,
    this.secondTitle,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        leading: IconButton(
            onPressed: () {
              appbarleadingFunction == null
                  ? Navigator.pop(context)
                  : appbarleadingFunction!();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            )),
        backgroundColor: Constants.screenColor,
        title: title,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            child: actionWidget,
          )
        ],
        elevation: 0,
      ),
    );
  }
}
