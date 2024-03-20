import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../color.dart';

class BuilderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BuilderAppBar({
    super.key,
    required this.media,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TColor.primary,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: 43,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(18)),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      "assets/svg/search_svg.svg",
                      width: 35,
                      height: 45,
                      fit: BoxFit.none,
                    ),
                    border: InputBorder.none,
                    hintText: "Search for music",
                    hintStyle: const TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/svg/notification.svg",
                    width: 25,
                    height: 25,
                  )),
              const SizedBox(width: 5),
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/svg/user.svg",
                    width: 25,
                    height: 25,
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
// TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
