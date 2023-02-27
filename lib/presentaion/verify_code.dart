import 'package:buttomy_application/common_widgets/app_bar_custom.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../common_widgets/button_custom.dart';
import '../common_widgets/test_custom.dart';
import '../core/constans/constants.dart';
import 'home_page.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

var box = GetStorage();

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
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
              decoration: const InputDecoration(hintText: "6 digit code"),
            ),
            Constants.height40,
            Constants.height10,
            ButtonCustom(
              mainAxisAlignment: MainAxisAlignment.start,
              buttonName: "Verify",
              loading: loading,
              buttonAction: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                  smsCode: phoneNumberController.text.toString(),
                  verificationId: widget.verificationId,
                );
                try {
                  await auth.signInWithCredential(credential);
                  box.write("login", true);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } catch (e) {}
              },
            )
          ],
        ),
      ),
    );
  }
}
