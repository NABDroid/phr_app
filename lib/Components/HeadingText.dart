import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Headingtext extends StatelessWidget {
  Headingtext({super.key, required this.text, required this.textColor, required this.alignment});
  String text;
  Color textColor;
  TextAlign alignment;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: textColor,fontSize: 18, fontFamily: GoogleFonts.abyssinicaSil().fontFamily),textAlign: alignment,);
  }
}



class Detailstext extends StatelessWidget {
  Detailstext({super.key, required this.text, required this.textColor, required this.alignment});
  String text;
  Color textColor;
  TextAlign alignment;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.normal, color: textColor,fontSize: 14, fontFamily: GoogleFonts.abyssinicaSil().fontFamily),textAlign: alignment,);
  }
}


//abyssinicaSil