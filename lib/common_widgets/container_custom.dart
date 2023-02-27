import 'package:flutter/material.dart';

import '../core/constans/constants.dart';

class ContainerCustom extends StatelessWidget {
  final Widget? child;
  final double? height, width;
  final Color? color;
  final double? blurRadius;
  const ContainerCustom({
    super.key,
    this.child,
    this.height,
    this.width,
    this.color,
    this.blurRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color ?? Constants.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(0.0, 1.5),
              blurRadius: blurRadius ?? 0,
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
