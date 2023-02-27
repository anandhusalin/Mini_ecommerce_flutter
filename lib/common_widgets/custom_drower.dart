import 'package:buttomy_application/common_widgets/test_custom.dart';
import 'package:buttomy_application/presentaion/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../core/constans/constants.dart';

class DrowerWidgetCustom extends StatelessWidget {
  const DrowerWidgetCustom({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.height / 3,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Constants.greyColor,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(70))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Column(
                  children: [
                    Image.network(
                      "https://th.bing.com/th/id/OIP.Gbb8Ao9hkmKfvRhDVAgKYgHaDZ?w=349&h=160&c=7&r=0&o=5&dpr=1.5&pid=1.7",
                      height: 120,
                      width: 120,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            Constants.height20,
            const TextCustom(
                weight: FontWeight.bold, size: 17, text1: "Arya Krishna M S "),
          ],
        ),
      ),
      Constants.height40,
      InkWell(
        onTap: () async {
          box.remove("login");
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.logout),
            TextCustom(
              text1: "Logout",
              weight: FontWeight.bold,
              size: 22,
            ),
            Constants.height40,
          ],
        ),
      )
    ]);
  }
}
