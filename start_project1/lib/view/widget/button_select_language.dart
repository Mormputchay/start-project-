import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:start_project1/color.dart';

class ButtonSelectLanguage extends StatelessWidget {
  ButtonSelectLanguage(
      {super.key,
      required this.onTap,
      required this.imageIcon,
      required this.title});
  String title;
  String imageIcon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          width: double.maxFinite,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: TColor.black, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SvgPicture.asset(
                  imageIcon,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 25),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
