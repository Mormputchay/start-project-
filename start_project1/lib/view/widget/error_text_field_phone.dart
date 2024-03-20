import 'package:flutter/material.dart';

import '../../color.dart';

class ErrorTextField extends StatelessWidget {
  const ErrorTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.right,
    this.onChanged,
    required this.errorTextField,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String labelText;
  final Widget? right;
  final Widget errorTextField;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: 48,
            decoration: BoxDecoration(
                color: TColor.black, borderRadius: BorderRadius.circular(7)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 50,
                  decoration: BoxDecoration(
                      color: TColor.red,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3))),
                ),
                errorTextField
              ],
            ),
          ),
        ],
      ),
    );
  }
}
