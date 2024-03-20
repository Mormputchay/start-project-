import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: camel_case_types
class Button_Menu_BootSheet extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onPress;

  const Button_Menu_BootSheet({
    super.key,
    required this.image,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.maxFinite,
      height: 50,
      onPressed: onPress,
      child: Row(
        children: [
          SvgPicture.asset(image),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 17, color: Colors.black),
          )
        ],
      ),
    );
  }
}
