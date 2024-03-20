import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../color.dart';

class RoundField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final FocusNode? focusNode;
  final Widget? right;
  final ValueChanged<String>? onFieldSubmitted;
  bool isReadOnly = false;
  RoundField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.keyboardType,
      this.obscureText,
      this.focusNode,
      this.right,
      this.onFieldSubmitted,
      this.onChanged,
      this.inputFormatters,
      required this.isReadOnly});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 45,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: TColor.black, borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            focusNode: focusNode,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            onFieldSubmitted: onFieldSubmitted,
            readOnly: isReadOnly,
            controller: controller,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            obscureText: obscureText!,
            onChanged: onChanged,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 12, bottom: 10, top: 5),
                border: InputBorder.none,
                focusColor: Colors.white,
                fillColor: Colors.white,
                suffixIcon: right,
                labelText: labelText,
                labelStyle: TextStyle(color: TColor.grey, fontSize: 15)),
          ),
        ),
      ],
    );
  }
}
