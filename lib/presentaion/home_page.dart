import 'package:buttomy_application/common_widgets/search_custom.dart';
import 'package:buttomy_application/core/constans/constants.dart';
import 'package:buttomy_application/provider/common_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../common_widgets/app_bar_custom.dart';
import '../common_widgets/button_custom.dart';
import '../common_widgets/container_custom.dart';
import '../common_widgets/custom_drower.dart';
import '../common_widgets/expansion_widget.dart';
import '../common_widgets/switch_button_custom.dart';
import '../common_widgets/test_custom.dart';

import 'checkout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  loadData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ignore: use_build_context_synchronously
      await Provider.of<CommonProvider>(context, listen: false).getFaqDetails();
      // ignore: use_build_context_synchronously
    });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  List listofTitle = [
    "Wall",
    "Menu",
    "Videos",
    "Reviews",
    "Blog",
  ];

  List<Icon> listofIcon = [
    const Icon(
      Icons.list,
    ),
    const Icon(Icons.food_bank_sharp),
    const Icon(Icons.video_camera_back_sharp),
    const Icon(Icons.star),
    const Icon(Icons.sensor_window),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.screenColor,
      appBar: const CustomAppBar(
        actionWidget: Icon(Icons.share),
        title: SearchBar(text: "Search Dish"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 10,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  Constants.dishImage,
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 70,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  TextCustom(
                                    text1: "Taza Kitchen",
                                    weight: FontWeight.bold,
                                    size: 18,
                                  ),
                                  TextCustom(
                                    text1: "From Peyad",
                                    size: 13,
                                    colorOfText: Constants.greyColor,
                                  ),
                                  TextCustom(
                                    text1: "Member Since Aug 16, 2021",
                                    size: 11,
                                    colorOfText: Constants.greyColor,
                                  ),
                                  TextCustom(
                                    text1: "FSSAI NO: 21321137000400",
                                    size: 11,
                                    colorOfText: Constants.greyColor,
                                  ),
                                  TextCustom(
                                    text1: "know more",
                                    size: 11,
                                    colorOfText: Constants.blueColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ButtonCustom(
                              iconSize: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              loading: false,
                              height: 30,
                              width: 80,
                              textSize: 13,
                              buttonAction: () {},
                              textColor: Constants.whiteColor,
                              color: Constants.secondaryColor,
                              buttonName: "Folllow",
                            ),
                            Constants.height10,
                            Row(
                              children: const [
                                TextCustom(
                                  text1: "4.6",
                                  weight: FontWeight.w900,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Constants.appcolor,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ContainerCustom(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 20,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              TextCustom(
                                text1: "14",
                                colorOfText: Constants.blueColor,
                              ),
                              Constants.width5,
                              TextCustom(
                                text1: "Posts",
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          Row(
                            children: const [
                              TextCustom(
                                text1: "37",
                                colorOfText: Constants.blueColor,
                              ),
                              Constants.width5,
                              TextCustom(
                                text1: "Followers",
                                weight: FontWeight.bold,
                              )
                            ],
                          )
                        ]),
                  ),
                ),
                Constants.height5,
                Consumer<CommonProvider>(builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 90,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listofTitle.length,
                          itemBuilder: (BuildContext, index) {
                            return InkWell(
                              onTap: () {
                                value.setindex(index);
                              },
                              child: Center(
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: value.index == index
                                                  ? Constants.appcolor
                                                  : Constants.screenColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: 80,
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              listofIcon[index],
                                              Constants.height5,
                                              TextCustom(
                                                  text1: listofTitle[index]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }),
                const Divider(
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Consumer<CommonProvider>(
                          builder: (context, value, child) {
                        return SwitchButtonCustom(
                          function: (val) {
                            value.setChangeSwitch(value.val);
                          },
                          text: "Veg",
                          val: value.val,
                        );
                      }),
                      Consumer<CommonProvider>(
                          builder: (context, value, child) {
                        return SwitchButtonCustom(
                          function: (val) {
                            value.setChangeSwitch(value.val2);
                          },
                          text: "Non Veg",
                          val: value.val2,
                        );
                      })
                    ],
                  ),
                ),
                Consumer<CommonProvider>(builder: (context, value, child) {
                  if (!value.faqloader) {
                    var data = value.faqlList!.data;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.faqlList!.data!.length,
                      itemBuilder: (context, index) {
                        return ExpansionWidget(
                          products: data![index].products!,
                          title: data[index].categoryName!,
                          comment: data[index].categoryName!,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
              ],
            ),
          ),
          ContainerCustom(
            color: Constants.greenColor,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Consumer<CommonProvider>(
                              builder: (context, value, child) {
                            return TextCustom(
                                size: 18,
                                text1: value.cartTotalCount.toString());
                          }),
                          Constants.width5,
                          const TextCustom(size: 18, text1: "Items")
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CheckoutScreen()));
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
          )
        ],
      ),
      drawer: const Drawer(
        child: DrowerWidgetCustom(),
      ),
    );
  }
}
