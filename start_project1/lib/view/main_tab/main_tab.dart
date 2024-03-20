import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../color.dart';
import '../screen/Feed/FeedScreen.dart';
import '../screen/home/home.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});
  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  TabController? controller;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const Center(
      child: Text("Music"),
    ),
    const FeedScreen(),
    const Center(
      child: Text("product"),
    ),
    const Center(
      child: Text("Cart"),
    ),
  ];
  void _onItemTap(int index) {
    setState(() {
      selectTab = index;
    });
  }

  int selectTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(selectTab),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectTab,
        elevation: 4,
        type: BottomNavigationBarType.fixed,
        backgroundColor: TColor.Color_Maintab,
        unselectedFontSize: 13,
        selectedFontSize: 13,
        unselectedItemColor: Colors.grey,
        selectedItemColor: TColor.primary,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        onTap: _onItemTap,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/home_svg.svg",
                width: 20,
                height: 20,
                color: selectTab == 0 ? TColor.primary : Colors.grey,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/Music_svg.svg",
                width: 20,
                height: 20,
                color: selectTab == 1 ? TColor.primary : Colors.grey,
              ),
              label: "Music"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/Feed_svg.svg",
                width: 20,
                height: 20,
                color: selectTab == 2 ? TColor.primary : Colors.grey,
              ),
              label: "Feed"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/product_svg.svg",
                width: 20,
                height: 20,
                color: selectTab == 3 ? TColor.primary : Colors.grey,
              ),
              label: "Product"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/Cart_svg.svg",
                width: 20,
                height: 20,
                color: selectTab == 4 ? TColor.primary : Colors.grey,
              ),
              label: "Cart"),
        ],
      ),
    );
  }
}
