import 'package:flutter/material.dart';

class Text_Dates_Row_Meun extends StatelessWidget {
  const Text_Dates_Row_Meun({
    super.key,
    required this.date,
    required this.onTap,
    required this.icon,
  });
  final String date;
  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          date,
          style: const TextStyle(fontSize: 15, color: Color(0xFF575757)),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: onTap,
          child: Image.asset(
            icon,
            width: 15,
            height: 15,
          ),
        ),
      ],
    );
  }
}
