import 'package:buttomy_application/common_widgets/app_bar_custom.dart';
import 'package:buttomy_application/common_widgets/button_custom.dart';
import 'package:buttomy_application/core/constans/constants.dart';
import 'package:buttomy_application/presentaion/verify_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../common_widgets/test_custom.dart';

class LoginWithPhoneNUmber extends StatefulWidget {
  const LoginWithPhoneNUmber({super.key});

  @override
  State<LoginWithPhoneNUmber> createState() => _LoginWithPhoneNUmberState();
}

class _LoginWithPhoneNUmberState extends State<LoginWithPhoneNUmber> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: TextCustom(text1: "login with phone number")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Constants.height40,
            Constants.height10,
            TextField(
              keyboardType: TextInputType.number,
              controller: phoneNumberController,
              decoration: const InputDecoration(
                  hintText: "Please enter your phone number"),
            ),
            Constants.height40,
            Constants.height10,
            ButtonCustom(
              mainAxisAlignment: MainAxisAlignment.start,
              buttonName: "Login",
              loading: loading,
              buttonAction: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: "+91 ${phoneNumberController.text}",
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      setState(() {
                        loading = false;
                      });
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyCodeScreen(
                                    verificationId: verificationId,
                                  )));
                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      setState(() {
                        loading = false;
                      });
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
