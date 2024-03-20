import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../color.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.primary,
      body: SafeArea(
        child: Container(
          height: media.height,
          width: media.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "assets/svg/Coming_soon.svg",
                      width: 126,
                      height: 127,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                        child: SvgPicture.asset(
                      "assets/svg/OvleringFeed.svg",
                      width: 146,
                      height: 90,
                      fit: BoxFit.cover,
                    )),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "We are in development",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: TColor.black,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "We will notify to you after we complete develop.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 28.5,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
