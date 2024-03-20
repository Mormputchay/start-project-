import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:start_project1/view/main_tab/main_tab.dart';
import 'package:start_project1/view/screen/Internet_Connection/Loading.dart';
import 'package:start_project1/view/screen/Internet_Connection/NoInternet.dart';
import 'package:start_project1/view/screen/select_2_language/select_2_language_screen.dart';

class InternetScreen extends StatefulWidget {
  const InternetScreen({super.key});
  @override
  State<InternetScreen> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            print(snapshot.toString());
            if (snapshot.hasData) {
              ConnectivityResult? result = snapshot.data;
              if (result == ConnectivityResult.mobile) {
                return const MainTab();
              } else if (result == ConnectivityResult.wifi) {
                return const Select2LanguageScreen();
              } else {
                return const NoInternet();
              }
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
  }

  Widget connected(String type) {
    return Center(
      child: Text(
        '$type Connected',
        style: const TextStyle(color: Colors.green, fontSize: 20),
      ),
    );
  }
}
