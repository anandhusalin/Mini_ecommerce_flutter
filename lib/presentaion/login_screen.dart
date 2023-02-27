import 'package:buttomy_application/common_widgets/button_custom.dart';
import 'package:buttomy_application/core/constans/constants.dart';
import 'package:buttomy_application/presentaion/Login_with_phone_number.dart';
import 'package:buttomy_application/provider/common_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    return Scaffold(
      body: ListView(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        SizedBox(
            height: 150,
            width: 150,
            child: Image.asset("asset/images/firebase.png")),
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<CommonProvider>(builder: (context, value, child) {
            return ButtonCustom(
              mainAxisAlignment: MainAxisAlignment.start,
              loading: false,
              buttonAction: () async {
                try {
                  final UserCredential userCredential =
                      await signInWithGoogle();
                  value.storeImageAndName(
                      image: userCredential.user!.photoURL,
                      name: userCredential.user!.displayName);

                  box.write("login", true);

                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                } catch (e) {}
              },
              image: Constants.googleImage,
              color: Colors.blue,
              textColor: Colors.white,
              buttonName: "Google",
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonCustom(
              mainAxisAlignment: MainAxisAlignment.start,
              color: Colors.green,
              icon: Icons.phone,
              textColor: Colors.white,
              loading: false,
              buttonAction: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginWithPhoneNUmber()));
              },
              buttonName: "Phone"),
        )
      ]),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential;
  }
}
