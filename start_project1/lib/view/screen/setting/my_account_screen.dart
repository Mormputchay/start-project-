import 'package:flutter/material.dart';
import 'package:start_project1/color.dart';
import 'package:start_project1/view/screen/setting/SingleChoiceDialog.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});
  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  String? selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                width: double.maxFinite,
                height: 55,
                decoration: BoxDecoration(
                    color: TColor.black,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => const SingleChoiceDialog());
                        },
                        child: Text(
                          selectedGender!,
                          style: const TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
