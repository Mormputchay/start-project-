import 'package:flutter/material.dart';
import 'package:start_project1/color.dart';

class TabTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isActive;
  const TabTextButton(
      {super.key,
        required this.title,
        this.isActive = false,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 130,
        height: 40,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    const Spacer(),
                    if (isActive)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          color: TColor.black,
                          width: double.maxFinite,
                          height: 2,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Text(
              title,
              style: TextStyle(
                  color: TColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}