import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Headingtext extends StatelessWidget {
  Headingtext({super.key, required this.text, required this.textColor});
  String text;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: textColor,fontSize: 18, fontFamily: GoogleFonts.abyssinicaSil().fontFamily),);
  }
}


//abyssinicaSil