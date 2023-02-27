import 'package:buttomy_application/common_widgets/app_bar_custom.dart';
import 'package:buttomy_application/common_widgets/button_custom.dart';
import 'package:buttomy_application/common_widgets/container_custom.dart';
import 'package:buttomy_application/common_widgets/test_custom.dart';
import 'package:buttomy_application/core/constans/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_widgets/helper.dart';
import '../db/db_model.dart';
import '../provider/common_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ignore: use_build_context_synchronously
      await Provider.of<CommonProvider>(context, listen: false)
          .getAllCartItems();
      // ignore: use_build_context_synchronously
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.screenColor,
      appBar: CustomAppBar(
          title: const TextCustom(text1: "My Cart"),
          actionWidget:
              Consumer<CommonProvider>(builder: (context, value, child) {
            return InkWell(
              onTap: () {
                value.clearCart();
              },
              child: Row(
                children: const [
                  Icon(Icons.delete),
                  TextCustom(text1: "Clear Cart")
                ],
              ),
            );
          })),
      body: Consumer<CommonProvider>(builder: (context, value, child) {
        return Column(
          children: [
            const Divider(
              color: Constants.greyColor,
              thickness: 3,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Constants.height40,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ContainerCustom(
                      color: Constants.whiteColor,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.cartItems.length,
                          itemBuilder: (BuildContext, index) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 160,
                                        child: TextCustom(
                                            text1: value.cartItems[index].name),
                                      ),
                                      TextCustom(
                                          text1:
                                              "₹ ${value.cartItems[index].price}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ContainerCustom(
                                        height: 30,
                                        width: 80,
                                        color: Constants.screenColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  var cartValue = CartItem(
                                                      quantity: value
                                                              .cartItems[index]
                                                              .quantity
                                                              .toInt() -
                                                          1,
                                                      name: value
                                                          .cartItems[index]
                                                          .name,
                                                      price: value
                                                          .cartItems[index]
                                                          .price
                                                          .toDouble());

                                                  value.modifyhiveCartItem(
                                                      cartValue, false);
                                                  value.updateCartCount(
                                                      value.cartItems[index]
                                                          .name,
                                                      false);
                                                  value.getAllCartItems();
                                                },
                                                child: const TextCustom(
                                                  text1: "-",
                                                  size: 26,
                                                )),
                                            TextCustom(
                                                text1: value
                                                    .cartItems[index].quantity
                                                    .toString()),
                                            InkWell(
                                                onTap: () {
                                                  var cartValue = CartItem(
                                                      quantity: value
                                                              .cartItems[index]
                                                              .quantity
                                                              .toInt() +
                                                          1,
                                                      name: value
                                                          .cartItems[index]
                                                          .name,
                                                      price: value
                                                          .cartItems[index]
                                                          .price
                                                          .toDouble());

                                                  value.modifyhiveCartItem(
                                                      cartValue, true);
                                                  value.updateCartCount(
                                                      value.cartItems[index]
                                                          .name,
                                                      true);
                                                  value.getAllCartItems();
                                                },
                                                child: const TextCustom(
                                                  text1: "+",
                                                  size: 25,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Constants.width20,
                                      TextCustom(
                                          text1:
                                              "₹ ${(value.cartItems[index].quantity) * (value.cartItems[index].price)}"),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextCustom(
                      text1: "Bill Details",
                      weight: FontWeight.bold,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ContainerCustom(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextCustom(text1: "Item total"),
                                TextCustom(
                                    textAlign: TextAlign.right,
                                    text1: "₹ ${value.totalPrice}")
                              ],
                            ),
                            Constants.height10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextCustom(text1: "Taxes & Charges"),
                                TextCustom(
                                    textAlign: TextAlign.right,
                                    text1: "₹ ${value.taxes}")
                              ],
                            ),
                            Constants.height40,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextCustom(
                                  text1: "GRAND TOTAL",
                                  size: 18,
                                  weight: FontWeight.bold,
                                ),
                                TextCustom(
                                    size: 18,
                                    weight: FontWeight.bold,
                                    textAlign: TextAlign.right,
                                    text1:
                                        "₹ ${value.totalPrice + value.taxes}")
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonCustom(
                mainAxisAlignment: MainAxisAlignment.center,
                buttonAction: () async {
                  HelperDialogue().dialugue(
                      title: "Alert",
                      context: context,
                      content: "Order successfully placed",
                      onPressed: () {
                        value.clearCart();

                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                },
                buttonName: "Place Order",
                loading: false,
                color: Constants.appcolor,
                textColor: Constants.secondaryColor,
              ),
            )
          ],
        );
      }),
    );
  }
}
