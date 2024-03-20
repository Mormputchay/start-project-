import 'package:flutter/material.dart';

import '../../../color.dart';
import '../../widget/appbar.dart';
import '../../widget/round_button.dart';
import '../../widget/round_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formfield = GlobalKey<FormState>();
  TextEditingController txtUserController = TextEditingController();

  String errorTextUser = '';
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: TColor.primary,
      appBar: const BuilderAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 34),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Forget Password",
                style: TextStyle(
                    fontSize: 27,
                    color: TColor.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Enter your phone number to receive \nverification code.",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundField(
                isReadOnly: false,
                onChanged: (value) {},
                labelText: "Your Phone number or Email",
                controller: txtUserController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RoundButton(title: "Send", onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
