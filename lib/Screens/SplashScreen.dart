import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phr_app/Components/Global.dart';
import '../Components/HeadingText.dart';
import 'HomePage.dart';

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
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: themeColorDark,
        child: Center(
          child: Headingtext(text: "Personal Health Record - PHR",textColor: textColorLite,),
        ),
      ),
    );
  }
}
