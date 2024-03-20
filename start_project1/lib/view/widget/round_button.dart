import 'package:flutter/material.dart';

import '../../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const RoundButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      minWidth: double.maxFinite,
      color: TColor.black,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 17),
      ),
    );
  }
}
