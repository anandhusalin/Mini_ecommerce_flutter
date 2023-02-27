import 'package:buttomy_application/common_widgets/container_custom.dart';
import 'package:buttomy_application/common_widgets/test_custom.dart';
import 'package:buttomy_application/core/constans/constants.dart';
import 'package:buttomy_application/provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/db_model.dart';
import '../model/buttomy_model.dart';

class ExpansionWidget extends StatelessWidget {
  final String title;
  final String comment;
  final List<Product> products;
  const ExpansionWidget({
    Key? key,
    required this.title,
    required this.comment,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the Hive box for cart items

    return Consumer<CommonProvider>(builder: (context, value, child) {
      return Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
          expansionTileTheme: ExpansionTileThemeData(
            collapsedBackgroundColor: Constants.screenColor,
            iconColor: Colors.grey,
            backgroundColor:
                value.isExpanded ? Colors.grey.withOpacity(0.2) : null,
          ),
        ),
        child: Column(
          children: [
            ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
              title: TextCustom(
                text1: title,
                colorOfText: Constants.secondaryColor,
                maxLines: 10,
              ),
              children: [
                Column(
                  children: [
                    Consumer<CommonProvider>(
                        builder: (context, providervalue, child) {
                      return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width - 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const ContainerCustom(
                                                blurRadius: 0,
                                                height: 10,
                                                width: 30,
                                                color: Constants.redColor),
                                            SizedBox(
                                              width: 200,
                                              child: TextCustom(
                                                maxLines: 2,
                                                text1: products[index]
                                                    .kitchenItemName!,
                                                weight: FontWeight.bold,
                                                size: 18,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: TextCustom(
                                                text1: "(1 min qty)",
                                                size: 13,
                                                colorOfText:
                                                    Constants.greyColor,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    " ₹ ${products[index].kitchenItemAmount!}",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: TextCustom(
                                                      text1:
                                                          " ₹ ${products[index].itemDiscountPrice!}",
                                                      size: 16,
                                                      colorOfText: Constants
                                                          .secondaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            products[index]
                                                .kitchenItemImage![0]
                                                .images!,
                                            fit: BoxFit.cover,
                                            height: 60,
                                            width: 70,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  height: 60,
                                                  width: 70,
                                                  Constants.dishImage);
                                            },
                                          )),
                                      Constants.height5,
                                      ContainerCustom(
                                        height: 30,
                                        width: 80,
                                        color: Constants.greenColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  var cartValue = CartItem(
                                                      quantity: products[index]
                                                              .cartCount!
                                                              .toInt() -
                                                          1,
                                                      name: products[index]
                                                          .kitchenItemName!,
                                                      price: products[index]
                                                          .itemDiscountPrice!
                                                          .toDouble());

                                                  providervalue.modifyCartItem(
                                                      cartValue, false);
                                                  providervalue.updateCartCount(
                                                      products[index]
                                                          .kitchenItemName!,
                                                      false);
                                                },
                                                child: const TextCustom(
                                                  text1: "-",
                                                  size: 26,
                                                )),
                                            TextCustom(
                                                text1:
                                                    '${products[index].cartCount ?? 0}'),
                                            InkWell(
                                                onTap: () async {
                                                  var cartValue = CartItem(
                                                      quantity: 1,
                                                      name: products[index]
                                                          .kitchenItemName!,
                                                      price: products[index]
                                                          .itemDiscountPrice!
                                                          .toDouble());

                                                  providervalue.modifyCartItem(
                                                      cartValue, true);
                                                  providervalue.updateCartCount(
                                                      products[index]
                                                          .kitchenItemName!,
                                                      true);
                                                },
                                                child: const TextCustom(
                                                  text1: "+",
                                                  size: 25,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Constants.height10,
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const SizedBox();
                          },
                          itemCount: products.length);
                    })
                  ],
                )
              ],
              onExpansionChanged: (expand) {
                value.setexpansion(expand);
              },
            ),
            const Divider(
              color: Constants.greyColor,
              thickness: 2,
            ),
          ],
        ),
      );
    });
  }
}
