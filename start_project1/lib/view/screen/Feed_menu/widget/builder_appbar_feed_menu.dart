// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:start_project1/color.dart';

AppBar BuildAppBarFeedMeun() {
  return AppBar(
    backgroundColor: TColor.primary,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 40,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(16)),
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
        const SizedBox(width: 7),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/svg/notification.svg",
                  width: 22,
                  height: 22,
                )),
            const SizedBox(width: 5),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/svg/user.svg",
                  width: 22,
                  height: 22,
                )),
          ],
        )
      ],
    ),
    bottom: TabBar(
      unselectedLabelColor: TColor.grey,
      labelColor: TColor.black,
      tabs: const [
        Tab(
          child: Text(
            "New feed",
            style: TextStyle(fontSize: 17), // Set the desired font size
          ),
        ),
        Tab(
          child: Text(
            "Friends",
            style: TextStyle(fontSize: 17), // Set the desired font size
          ),
        )
      ],
      indicatorColor: Colors.black,
      indicatorWeight: 2,
    ),
  );
}
