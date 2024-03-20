import 'package:flutter/material.dart';

import '../../color.dart';

class Text_ViewAll extends StatelessWidget {
  final String title;
  const Text_ViewAll({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 5,
                height: 30,
                color: TColor.black,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(
                    fontSize: 25,
                    color: TColor.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Text(
            "View all",
            style: TextStyle(
              fontSize: 16,
              color: TColor.white,
            ),
          )
        ],
      ),
    );
  }
}
