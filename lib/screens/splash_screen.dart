import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kek_app/screens/home.dart';
import 'package:kek_app/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'KeK',
                    style: comfortaaRedTextStyle.copyWith(
                        fontWeight: bold, fontSize: 64),
                  ),
                  Text(
                    'Health App',
                    style: comfortaaBlueTextStyle.copyWith(
                        fontWeight: bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Deteksi',
                    style: comfortaaRedTextStyle.copyWith(
                        fontSize: 16, fontWeight: bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Kekurangan Energi',
                    style: comfortaaBlueTextStyle.copyWith(
                        fontSize: 16, fontWeight: bold),
                  ),
                ],
              ),
              Text(
                'Kronik',
                style: comfortaaBlueTextStyle.copyWith(
                    fontSize: 16, fontWeight: bold),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Text('v 1.0'),
          )
        ],
      ),
    );
  }
}
