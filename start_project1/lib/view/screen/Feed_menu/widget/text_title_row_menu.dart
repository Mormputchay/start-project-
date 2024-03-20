// ignore_for_file: camel_case_types

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Text_Title_Row_Menu extends StatelessWidget {
  const Text_Title_Row_Menu({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
  });
  final String title;
  final String icon;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onPress,
          child: SvgPicture.asset(
            icon,
            width: 15,
            height: 15,
          ),
        ),
        const SizedBox(width: 8),
        AutoSizeText(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.black),
          minFontSize: 15,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
