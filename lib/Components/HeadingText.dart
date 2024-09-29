import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HeadingText extends StatelessWidget {
  HeadingText({super.key, required this.text, required this.textColor, required this.alignment});
  String text;
  Color textColor;
  TextAlign alignment;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: textColor,fontSize: 18, fontFamily: GoogleFonts.abyssinicaSil().fontFamily),textAlign: alignment,);
  }
}



class DetailsText extends StatelessWidget {
  DetailsText({super.key, required this.text, required this.textColor, required this.alignment});
  String text;
  Color textColor;
  TextAlign alignment;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.normal, color: textColor,fontSize: 14, fontFamily: GoogleFonts.abyssinicaSil().fontFamily),textAlign: alignment,);
  }
}


//abyssinicaSil