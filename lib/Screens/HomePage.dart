import 'package:flutter/material.dart';
import 'package:phr_app/Components/HeadingText.dart';

import '../Components/Global.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Headingtext(text: "Home", textColor: textColorLite,alignment: TextAlign.start),backgroundColor: themeColorDark,),
      body: Container(
        color: themeColorLite,
      ),
    );
  }
}
