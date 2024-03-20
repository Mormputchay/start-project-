// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../color.dart';
import '../../../model/UserRegister.dart';
import '../../../utils/Utils.dart';
import '../../../utils/next_screen.dart';
import '../../main_tab/main_tab.dart';
import '../../widget/appbar.dart';
import '../../widget/error_text_field_phone.dart';
import '../../widget/round_button.dart';
import '../../widget/round_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formField = GlobalKey<FormState>();
  TextEditingController txtFirstname = TextEditingController();
  TextEditingController txtLastname = TextEditingController();
  TextEditingController txtYourPhone = TextEditingController(text: '679234568');
  TextEditingController txtDigitCode = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isCheck = false;
  bool isShow = false;
  bool isCheckText = false;
  String errorTextFirstName = '';
  String errorTextLastName = '';
  String errorTextPhone = '';
  String errorTextDigitCode = '';
  String errorTextPassword = '';
  bool checkcolor = true;
  dynamic myTimer;
  bool _isButtonClicked = false;
  int countTime = 0;
  FocusNode fieldFirstname = FocusNode();
  FocusNode fieldLastName = FocusNode();
  FocusNode fieldPhone = FocusNode();
  FocusNode fieldDigitCode = FocusNode();
  FocusNode fieldPassword = FocusNode();
  StatusCode _statusCode = StatusCode.isSend;

  late SharedPreferences _pref;

  bool otpVisibility = false;

  late String myVerificationId = '';
  late String phoneNumber;
  late String otpCode = '';
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: Scaffold(
        backgroundColor: TColor.primary,
        resizeToAvoidBottomInset: false,
        appBar: const BuilderAppBar(),
        body: SafeArea(
          child: Form(
            key: _formField,
            child: SingleChildScrollView(
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: media.width * 0.60,
                          height: 55,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 20,
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RoundField(
                            isReadOnly: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[a-zA-Z0-9\s\u1780-\u17FF]+$')),
                            ],
                            focusNode: fieldFirstname,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(fieldLastName);
                            },
                            controller: txtFirstname,
                            labelText: "First name",
                            keyboardType: TextInputType.text,
                            obscureText: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              errorTextFirstName.isEmpty
                                  ? const SizedBox()
                                  : Text(
                                      errorTextFirstName,
                                      style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RoundField(
                            focusNode: fieldLastName,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[a-zA-Z0-9\s\u1780-\u17FF]+$')),
                            ],
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(fieldPhone);
                            },
                            isReadOnly: false,
                            controller: txtLastname,
                            labelText: "Last name",
                            keyboardType: TextInputType.text,
                            obscureText: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              errorTextLastName.isEmpty
                                  ? const SizedBox()
                                  : Text(
                                      errorTextLastName,
                                      style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        errorTextPhone.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: RoundField(
                                  focusNode: fieldPhone,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(fieldDigitCode);
                                  },
                                  isReadOnly: false,
                                  controller: txtYourPhone,
                                  onChanged: (e) {
                                    txtDigitCode.text = "";
                                    setState(() {
                                      _statusCode = StatusCode.isSend;
                                    });
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  labelText: "Your Phone",
                                  keyboardType: TextInputType.phone,
                                  obscureText: false,
                                ),
                              )
                            : ErrorTextField(
                                controller: txtYourPhone,
                                labelText: "Your YourPhone",
                                errorTextField: Expanded(
                                  child: RoundField(
                                    focusNode: fieldPhone,
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(fieldDigitCode);
                                    },
                                    isReadOnly: false,
                                    controller: txtYourPhone,
                                    onChanged: (e) {
                                      txtDigitCode.text = "";
                                      setState(() {
                                        _statusCode = StatusCode.isSend;
                                      });
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    labelText: "Your Phone",
                                    keyboardType: TextInputType.phone,
                                    obscureText: false,
                                  ),
                                ),
                              ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RoundField(
                            controller: txtDigitCode,
                            focusNode: fieldDigitCode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(fieldPassword);
                            },
                            isReadOnly: _statusCode == StatusCode.isDone,
                            onChanged: (value) {
                              setState(() {
                                otpCode = value;

                                if (otpCode.length == 6) {
                                  signInWithOTP(otpCode);
                                }
                              });
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            labelText: "DigitCode",
                            right:
                                _buildButton(), // Use _buildButton() as the value for the right property
                            keyboardType: TextInputType.number,
                            obscureText: false,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              errorTextDigitCode.isEmpty
                                  ? const SizedBox()
                                  : Text(
                                      errorTextDigitCode,
                                      style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RoundField(
                            isReadOnly: false,
                            focusNode: fieldPassword,
                            controller: txtPassword,
                            labelText: "Password",
                            keyboardType: TextInputType.visiblePassword,
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
                            obscureText: isShow,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              errorTextPassword.isEmpty
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Text(
                                        errorTextPassword,
                                        style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheck = !isCheck;
                                    print(isCheck);
                                  });
                                },
                                child: SvgPicture.asset(
                                    isCheck
                                        ? "assets/svg/check_box_true_svg.svg"
                                        : "assets/svg/check_box_svg.svg",
                                    semanticsLabel: 'A red up arrow'),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: const TextSpan(
                                          text: 'I have read and accept the ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                          children: <TextSpan>[
                                            TextSpan(
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: 'Terms & conditions '),
                                            TextSpan(
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(text: 'and '),
                                            TextSpan(
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(text: 'privacy & policy'),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RoundButton(
                            title: "Next",
                            onPressed: () async {
                              // First Name
                              if (txtFirstname.text.isEmpty) {
                                setState(() {
                                  errorTextFirstName =
                                      "Input Your Your First Name"; //Password ទទេរ
                                });
                              } else {
                                errorTextFirstName = "";
                              }
                              // Last Name
                              if (txtLastname.text.isEmpty) {
                                setState(() {
                                  errorTextLastName =
                                      "Input Your Your Last Name"; //Password ទទេរ
                                });
                              } else {
                                errorTextLastName = "";
                              }
                              // Phone Number
                              if (isPhoneNumber(txtYourPhone.text)) {
                                errorTextPhone = "";
                                setState(() {
                                  checkcolor = !checkcolor;
                                  print(isCheck);
                                });
                              } else if (txtYourPhone.text.isEmpty) {
                                setState(() {
                                  errorTextPhone =
                                      "Please Input your Phone Number";
                                  setState(() {
                                    checkcolor = !checkcolor;
                                  });
                                });
                              } else {
                                errorTextPhone =
                                    "Phone Input Your Phone number Again";
                                setState(() {
                                  checkcolor = !checkcolor;
                                  print(isCheck);
                                });
                              }
                              // Digit Code
                              if (txtDigitCode.text.isEmpty) {
                                setState(() {
                                  errorTextDigitCode =
                                      "Please Input your Digit Code";
                                });
                              } else if (txtDigitCode.text.length == 6) {
                                // String otpCode1 = txtDigitCode.text;
                                // signInWithOTP(otpCode1, verificationId);
                                // setState(() {
                                //   errorTextDigitCode = "";
                                // });
                              } else {
                                setState(() {
                                  errorTextDigitCode = "Wrong OTP code";
                                });
                              }
                              // Password
                              if (txtPassword.text.isEmpty) {
                                errorTextPassword =
                                    "Please Input your Password.";
                              } else if (!validatePassword(txtPassword.text)) {
                                errorTextPassword =
                                    "Password must contain at least 6 characters uppercase letter, and number";
                              } else {
                                errorTextPassword = "";
                              }
                              //All
                              if (_formField.currentState!.validate()) {
                                if (txtFirstname.text.isNotEmpty &&
                                    txtLastname.text.isNotEmpty &&
                                    isPhoneNumber(txtYourPhone.text) &&
                                    validatePassword(txtPassword.text)) {
                                  if (txtDigitCode.text.length == 6) {
                                    registerUser();
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 7),
                            InkWell(
                              onTap: () {
                                nextScreen(context, const LoginScreen());
                              },
                              child: const Text(
                                "Log In",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<UserRegister> registerUser() async {
    //log("dsdsdsd $UserRegister");

    var simulatedResponse = await http
        .post(Uri.parse('https://stage.cint-cam.com/api/v1/register'), body: {
      "first_name": txtFirstname.text.trim(),
      "last_name": txtLastname.text.trim(),
      "password": txtPassword.text.trim(),
      'mobile': txtYourPhone.text.trim(),
      "idToken": "asdfghgsafuytrryu",
      'gender': '1',
    });

    // ignore: duplicate_ignore
    if (simulatedResponse.statusCode == 200) {
      final json1 = jsonDecode(simulatedResponse.body);

      if (json1['code'] == 0) {
        var token = json1['data']['Token'];
        print(token);
        final SharedPreferences prefs = _pref;
        await prefs?.setString('token', token);

        txtFirstname.clear();
        txtLastname.clear();
        txtYourPhone.clear();
        txtDigitCode.clear();
        txtPassword.clear();
        print("Register success");
        var sharePref = await SharedPreferences.getInstance();
        sharePref.setBool("login", true);
      } else {}
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          closeIconColor: Colors.pink,
          content: Text('Register Success Account')));

      Navigator.of(context).popUntil((route) => route.isActive);

      if (isCheck = true) {
        Timer(const Duration(seconds: 3),
            () => nextScreenReplace(context, const MainTab()));
      }

      return UserRegister.fromJson(json.decode(simulatedResponse.body));
    } else {
      var json = jsonDecode(simulatedResponse.body);
      var data;
      List<String> dataValues = [];
      json['data'].forEach((key, value) {
        for (data in value) {
          dataValues.add(data.toString());
        }
      });
      String alertText = dataValues.join("\n");

      if (!_isButtonClicked) {
        setState(() {
          _isButtonClicked = true;
        });
        QuickAlert.show(
          context: context,
          barrierDismissible: false,
          type: QuickAlertType.error,
          confirmBtnText: 'ok',
          text: alertText,
          confirmBtnColor: TColor.red,
          onConfirmBtnTap: () {
            setState(() {
              _isButtonClicked = false;
            });
            Navigator.pop(context);
          },
        );
      }
      print('Response Data ${simulatedResponse.body}');
      throw Exception('Failed to register user');
    }
  }

  signInWithOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: myVerificationId,
      smsCode: otpCode,
    );
    try {
      var data = await FirebaseAuth.instance.signInWithCredential(credential);
      print("sdsddsdsd $data");
      // Handle sign-in success
      setState(() {
        _statusCode = StatusCode.isDone;
        errorTextDigitCode = "";
      });
    } catch (e) {
      // Handle sign-in failure
      print(e);
      setState(() {
        _statusCode = StatusCode.isReSend;
        errorTextDigitCode = "Wrong OTP code";
      });
    }
  }

  @override
  void dispose() {
    myTimer.cancel();
    super.dispose();
    txtFirstname.dispose();
    txtLastname.dispose();
    txtYourPhone.dispose();
    txtDigitCode.dispose();
    txtPassword.dispose();
  }

  void startCountdown() {
    int seconds = 60;
    countTime = 60;
    myTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_statusCode == StatusCode.isDone) {
        timer.cancel();
      }
      if (seconds == 0) {
        timer.cancel();
        setState(() {
          countTime = seconds;
          _statusCode = StatusCode.isReSend;
        });
        print('Countdown finished!');
      } else {
        print('Countdown: $seconds seconds');
        setState(() {
          countTime = seconds;
        });
        seconds--;
      }
    });
  }

  _buildButton() {
    if (_statusCode == StatusCode.isSend) {
      return TextButton(
        onPressed: () async {
          _getOtp();
        },
        child: Text(
          "Get Code",
          style: TextStyle(
            fontSize: 15,
            color: TColor.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else if (_statusCode == StatusCode.isReSend) {
      return GestureDetector(
        onTap: () {
          _getOtp();
        },
        child: SizedBox(
          width: 95,
          height: 50,
          child: Row(
            children: [
              Text("Resend",
                  style: TextStyle(
                    fontSize: 15,
                    color: TColor.primary,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(width: 8),
              SvgPicture.asset(
                "assets/svg/resend.svg",
                color: TColor.primary,
              ),
            ],
          ),
        ),
      );
    } else if (_statusCode == StatusCode.isGetTime) {
      //log("Get Time Count");
      return IconButton(
          onPressed: () {},
          icon: Text(
            "${countTime}s",
            style: TextStyle(
              color: TColor.primary,
            ),
          ));
    } else if (_statusCode == StatusCode.isDone) {
      return IconButton(
        onPressed: () {},
        icon: Image.asset(
          "assets/images/correct.png",
          width: 20,
          height: 20,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Lottie.asset('assets/images/loading.json', width: 20, height: 20);
    }
  }

  bool isPhoneNumber(String value) {
    //log("wwwww ${value.length >= 9}");
    if (value.length >= 9) {
      RegExp regex = RegExp(r'^\+?[0-9]{9,12}$');
      return regex.hasMatch(value);
    } else {
      return false;
    }
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

  _getOtp() async {
    String completePhoneNumber = "+855${txtYourPhone.text.trim()}";
    setState(() {
      _statusCode = StatusCode.isLoading;
    });
    await auth.verifyPhoneNumber(
      phoneNumber: completePhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("verificationFailed => $e");
        print("verificationCompleted => $credential");
        await auth.signInWithCredential(credential);
        setState(() {
          _statusCode = StatusCode.isDone;
          errorTextDigitCode = "Done";
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
        setState(() {
          _statusCode = StatusCode.isReSend;
          errorTextDigitCode = "Verification failed";
        });
        Utils().toastMessage(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        print("codeSent => $verificationId");
        print("codeSent => $resendToken");

        myVerificationId = verificationId;
        setState(() {
          _statusCode = StatusCode.isGetTime;
        });
        startCountdown();
        Utils().toastMessage("Send Otp Successfully $verificationId");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("verificationId $verificationId");
        // setState(() {
        //   _statusCode = StatusCode.isReSend;
        // });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Timed out waiting for SMS.')),
        // );
        // print("codeAutoRetrievalTimeout => $verificationId");
      },
    );
  }
}

enum StatusCode { isSend, isLoading, isReSend, isDone, isGetTime }
