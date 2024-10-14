import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phr_app/Components/Global.dart';


class HeadingText extends StatelessWidget {
  HeadingText({super.key, required this.text, this.textColor, this.alignment});
  String text;
  Color? textColor = textColorDark;
  TextAlign? alignment = TextAlign.start;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: textColor,fontSize: 18, fontFamily: GoogleFonts.abyssinicaSil().fontFamily),textAlign: alignment,);
  }
}



class DetailsText extends StatelessWidget {
  DetailsText({super.key, required this.text, this.textColor, this.alignment, this.fSize});
  String text;
  Color? textColor = textColorDark;
  TextAlign? alignment = TextAlign.start;
  double? fSize = 14;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.normal, color: textColor,fontSize: fSize, fontFamily: GoogleFonts.abyssinicaSil().fontFamily),textAlign: alignment,);
  }
}


//abyssinicaSil