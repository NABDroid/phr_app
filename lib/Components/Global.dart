import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phr_app/Models/UserInfo.dart';


String apiURL = "http://192.168.40.182:83";
// String apiURL = "http://192.168.0.107:83";
// String apiURL = "http://localhost:83";


Color themeColorDark = const Color(0xff2391BF);
Color themeColorLite = const Color(0xff697565);
Color appBackgroundColor = const Color(0xff84bcef);
Color textColorLite = Colors.white;
Color textColorDark = Colors.black;


String? defaultFont = GoogleFonts.abyssinicaSil().fontFamily;
TextStyle detailsTextStyle = TextStyle(fontSize: 14, fontFamily: defaultFont);
TextStyle headingTextStyle = TextStyle(fontSize: 18, fontFamily: defaultFont);
AssetImage backgroundImage = const AssetImage('asset/background.jpg');
UserInfo currentUserInfo = UserInfo(userId: 0, isActive: false);


