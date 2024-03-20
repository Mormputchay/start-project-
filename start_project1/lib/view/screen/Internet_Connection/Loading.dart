import 'dart:async';

import 'package:flutter/material.dart';
import 'package:start_project1/color.dart';

import 'NoInternet.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const NoInternet()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primary,
     body: const Center(
        child: CircularProgressIndicator(
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}