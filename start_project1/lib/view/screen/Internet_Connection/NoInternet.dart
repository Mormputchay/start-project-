import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:lottie/lottie.dart';
import 'package:start_project1/color.dart';
import 'package:start_project1/view/main_tab/main_tab.dart';

// ignore: non_constant_identifier_names
class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primary,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: SvgPicture.asset("assets/svg/Wifi.svg",
                  width: 100, height: 100)),
          const Text(
            "No Internet connection",
            style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 8),
          const Text("Check your connection, then refresh the page."),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              ConnectivityResult result =
              await Connectivity().checkConnectivity();
              if(result == ConnectivityResult.wifi) {

                // ignore: use_build_context_synchronously
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainTab()));
              }
            },
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: const Text('Refresh'),
          )
        ],
      ),
    );
  }
}