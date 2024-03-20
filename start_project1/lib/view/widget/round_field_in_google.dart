import 'package:flutter/material.dart';

class RoundFieldGoogle extends StatelessWidget {
  const RoundFieldGoogle({super.key,required this.controller, required this.hintText, this.keyboardType, this.focusNode, this.onFieldSubmitted});
  final TextEditingController controller;
  final String hintText;
  final  TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.center,
      child: SizedBox(
        height: 53,
        child: TextFormField(
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          keyboardType: keyboardType,
          style: const TextStyle(
              fontSize: 18,color: Colors.black
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey,fontSize: 18),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black, width: 1)),
          ),
        ),
      ),
    );
  }
}
