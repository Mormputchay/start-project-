// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_project1/view/screen/Internet_Connection/InterScreen.dart';

import '../../../color.dart';
import '../../../utils/next_screen.dart';
import '../../main_tab/main_tab.dart';
import '../Auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    whereToGo();
    super.initState();
  }

  static const String KEY_LOGIN = "login";
  void whereToGo() async {
    var sharePref = await SharedPreferences.getInstance();
    var isLoggedIn = sharePref.getBool(KEY_LOGIN);
    Timer(const Duration(seconds: 5), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          nextScreenReplace(context, const InternetScreen());
        } else {
          nextScreenReplace(context, const LoginScreen());
        }
      } else {
        nextScreenReplace(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: TColor.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          ))
        ],
      ),
    );
  }
}
