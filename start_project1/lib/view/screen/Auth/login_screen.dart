import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start_project1/view/screen/Auth/signUp_screen.dart';

import '../../../color.dart';
import '../../../utils/next_screen.dart';
import '../../main_tab/main_tab.dart';
import '../../widget/appbar.dart';
import '../../widget/round_button.dart';
import '../../widget/round_field.dart';
import 'ForgetPassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formfield = GlobalKey<FormState>();
  TextEditingController txtUserController = TextEditingController();
  TextEditingController txtUserPassword = TextEditingController();

  FocusNode fieldemail = FocusNode();
  FocusNode fieldpassword = FocusNode();
  bool isShow = false;
  String errorTextUser = '';

  String errorTextPassword = '';

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: TColor.primary,
      appBar: BuilderAppBar(
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Container(
                width: 85,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formfield,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: media.width * 0.65,
                      height: 68,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      "Welcome",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Enjoy thousand of your favorite songs",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RoundField(
                        focusNode: fieldemail,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(fieldpassword);
                        },
                        isReadOnly: false,
                        labelText: "Your Phone number or Email",
                        controller: txtUserController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          errorTextUser.isEmpty
                              ? const SizedBox()
                              : Text(
                                  errorTextUser,
                                  style: const TextStyle(color: Colors.red),
                                )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RoundField(
                        focusNode: fieldpassword,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(fieldpassword);
                        },
                        isReadOnly: false,
                        labelText: "Password",
                        right: IconButton(
                          onPressed: () {
                            setState(() {
                              isShow = !isShow;
                            });
                          },
                          icon: isShow
                              ? Image.asset(
                                  'assets/images/hide.png',
                                  color: Colors.white.withOpacity(0.6),
                                  width: 20,
                                  height: 20,
                                )
                              : SvgPicture.asset(
                                  "assets/svg/Icon feather-eye.svg"),
                        ),
                        controller: txtUserPassword,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isShow,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          errorTextPassword.isEmpty
                              ? const SizedBox()
                              : Expanded(
                                  child: Text(
                                    errorTextPassword,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RoundButton(
                        title: "Login",
                        onPressed: () async {
                          // Email
                          log("dslkdkdsds ${isPhoneNumber(txtUserController.text)}");
                          if (txtUserController.text.isEmpty) {
                            setState(() {
                              errorTextUser =
                                  "Please Input your Gmail Or Phone Number";
                            });
                          }
                          //Email ទទេរ
                          else if (isGmail(txtUserController.text)) {
                            if (txtUserController.text == "test@gmail.com") {
                              setState(() {
                                errorTextUser = "";
                              });
                            } else {
                              setState(() {
                                errorTextUser = "Wrong Gmail";
                              });
                            }
                            // errorTextUser =
                            //     "Please Input your Gmail Or Phone Number";
                          } else if (isPhoneNumber(txtUserController.text)) {
                            if (txtUserController.text == "012345678") {
                              //
                              setState(() {
                                errorTextUser = "";
                              });
                            } else {
                              setState(() {
                                errorTextUser = "Wrong Phone number";
                              });
                            }
                          } else {
                            setState(() {
                              errorTextUser =
                                  "Please Input your Gmail Or Phone Number";
                            });
                          }

                          log("errorTextUser $errorTextUser");

                          // Password

                          if (!validatePassword(txtUserPassword.text)) {
                            setState(() {
                              errorTextPassword =
                                  "Password must contain at least 6 characters uppercase letter, and number"; //Password ទទេរ
                            });
                          } else if (isGmail(txtUserController.text)) {
                            if (txtUserPassword.text == "123456") {
                              setState(() {
                                errorTextPassword = "";
                              });
                            } else {
                              setState(() {
                                errorTextPassword = "Wrong Password";
                              });
                            }
                          }
                          log("errorTextUser $errorTextPassword");
                          if (txtUserController.text == "test@gmail.com" &&
                              txtUserPassword.text == "Ase24356") {
                            nextMainScreen();
                          }
                          if (txtUserController.text == "012345678" &&
                              txtUserPassword.text == "Ase24356") {
                            nextMainScreen();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          nextScreen(context, const ForgetPasswordScreen());
                        },
                        child: const Text(
                          "forget password ?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: media.width * 0.6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 7),
                  InkWell(
                    onTap: () {
                      nextScreen(context, const SignUpScreen());
                    },
                    child: const Text(
                      "Create a new account",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isGmail(String value) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@gmail.com$');
    return regex.hasMatch(value);
  }

  bool isPhoneNumber(String value) {
    log("wwwww ${value.length >= 9}");
    if (value.length >= 9) {
      RegExp regex = RegExp(r'^\+?[0-9]{9,12}$');
      return regex.hasMatch(value);
    } else {
      return false;
    }
  }

  void saveUserLoginDetails(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  void nextMainScreen() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString("username", txtUserController.text);
    sp.setString("password", txtUserPassword.text);

    var sharePref = await SharedPreferences.getInstance();
    sharePref.setBool("login", true);
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ));
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Login Success Account')));
    // ignore: use_build_context_synchronously
    Navigator.of(context).popUntil((route) => route.isActive);
    // ignore: use_build_context_synchronously
    Timer(const Duration(seconds: 3),
        () => nextScreenReplace(context, const MainTab()));
  }

  bool validatePassword(String value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    if (value.length < 6) {
      return false;
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    return true;
  }
}
