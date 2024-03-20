import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../color.dart';
import '../../widget/button_select_language.dart';

class Select2LanguageScreen extends StatelessWidget {
  const Select2LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              ButtonSelectLanguage(
                onTap: () {
                  EasyLocalization.of(context)!.setLocale(Locale('km', 'KH'));
                },
                imageIcon: "assets/svg/khmer.svg",
                title: "ភាសាខ្មែរ",
              ),
              ButtonSelectLanguage(
                onTap: () {
                  EasyLocalization.of(context)!
                      .setLocale(const Locale('en', 'US'));
                },
                imageIcon: "assets/svg/english.svg",
                title: "English",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
