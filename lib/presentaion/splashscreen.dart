import 'package:buttomy_application/common_widgets/test_custom.dart';
import 'package:buttomy_application/presentaion/home_page.dart';
import 'package:buttomy_application/presentaion/login_screen.dart';
import 'package:buttomy_application/presentaion/verify_code.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5)).then((value) async {
      if (box.read("login") != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
    return const Scaffold(
      body: Center(
        child: TextCustom(
          text1: "BUTOMY",
          weight: FontWeight.bold,
          size: 30,
        ),
      ),
    );
  }
}
