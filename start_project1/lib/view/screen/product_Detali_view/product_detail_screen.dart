import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../color.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var listDevice = [
    "https://ae01.alicdn.com/kf/S227ff6c2f5b345c780e603487dc0806aZ/Electronic-Games-Bluetooth-Headset-Noise-Reduction-Eat-Chicken-Zero-Delay-Light-Game-Wireless-Earbuds-Bluetooth-Headphones.jpg",
    "https://ae01.alicdn.com/kf/S7ace657dbc13487eb958bfe1f024a7e1T/VOULAO-Bluetooth-5-3-Earphones-Wireless-Headphones-Gaming-Headset-Low-Latency-Sport-HiFi-Stereo-Noise-Reduction.jpg",
    "https://ae01.alicdn.com/kf/S227ff6c2f5b345c780e603487dc0806aZ/Electronic-Games-Bluetooth-Headset-Noise-Reduction-Eat-Chicken-Zero-Delay-Light-Game-Wireless-Earbuds-Bluetooth-Headphones.jpg"
  ];
  int currentIndex = 0;
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentIndex < listDevice.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      pageController.animateToPage(currentIndex,
          duration: const Duration(microseconds: 700), curve: Curves.easeIn);
    });
    super.initState();
  }

  final pageController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/svg/back.svg',
            width: 20,
            height: 14,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          'Product Detail',
          style: TextStyle(
              color: TColor.black, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/svg/message.svg",
                  width: 23, height: 23, fit: BoxFit.contain))
        ],
      ),
      backgroundColor: TColor.primary,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 225,
              child: Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                      print("value: $value");
                    });
                  },
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: true,
                  itemCount: listDevice.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          listDevice[index].toString(),
                          width: media.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  listDevice.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 8.5,
                    height: 8.5,
                    decoration: BoxDecoration(
                        color: currentIndex == index
                            ? TColor.black
                            : const Color(0XFF2F2E3A).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
