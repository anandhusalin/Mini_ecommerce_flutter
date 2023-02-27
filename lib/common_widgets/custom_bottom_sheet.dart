import 'package:buttomy_application/common_widgets/test_custom.dart';
import 'package:buttomy_application/presentaion/checkout_screen.dart';
import 'package:flutter/material.dart';
import '../core/constans/constants.dart';
import 'container_custom.dart';

class CustomBottamSheet extends StatelessWidget {
  const CustomBottamSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      color: Constants.greenColor,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    TextCustom(size: 18, text1: "1"),
                    Constants.width5,
                    TextCustom(size: 18, text1: "Items")
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckoutScreen()));
                  },
                  child: Row(
                    children: const [
                      TextCustom(size: 18, text1: "Add to Cart"),
                      Constants.width5,
                      Icon(Icons.shopping_cart_checkout)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
