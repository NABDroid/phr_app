import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phr_app/Components/Global.dart';
import '../Components/HeadingText.dart';
import 'BaseScreen.dart';
import 'Auth/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: backgroundImage,
              fit: BoxFit.cover, // Use BoxFit.cover to fill the entire screen
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Image(
                height: 120,
                width: 120,
                image: AssetImage('asset/appLogo.png'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: HeadingText(
                text:
                    "Welcome to \nPersonal Health Record (PHR)\nEco Friendly Medical Surveillance Record App",
                textColor: textColorDark,
                alignment: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: HeadingText(
                text: "Powered by: SAGA UNIVERSITY",
                textColor: textColorDark,
                alignment: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
