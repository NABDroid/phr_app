import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phr_app/Screens/AmbulanceListScreen.dart';
import 'package:phr_app/Screens/DoctorsListScreen.dart';
import 'package:phr_app/Services/HospitalServices.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/Global.dart';
import '../Components/HeadingText.dart';


class HospitalDetailsScreen extends StatefulWidget {
  final int hospitalId;

  const HospitalDetailsScreen({required this.hospitalId});

  @override
  State<HospitalDetailsScreen> createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: HeadingText(
            text: 'Hospital Details',
            textColor: textColorLite,
          ),
          backgroundColor: themeColorDark,
        ),
        body: (currentScreen == 0)?AmbulanceList(hospitalId: widget.hospitalId):DoctorListPage(hospitalId: widget.hospitalId),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: textColorDark,
          selectedLabelStyle: TextStyle(fontFamily: defaultFont),
          selectedIconTheme: IconThemeData(color: textColorDark),
          unselectedItemColor: themeColorLite,
          unselectedLabelStyle: TextStyle(fontFamily: defaultFont),
          unselectedIconTheme: IconThemeData(color: themeColorLite),
          showUnselectedLabels: true,
          selectedFontSize: 14,
          unselectedFontSize: 10,
          currentIndex: currentScreen,
          onTap: (tappedIndex) {
            currentScreen = tappedIndex;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.car_crash_sharp),
                label: "Ambulances",
                backgroundColor: appBackgroundColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                label: "Doctors",
                backgroundColor: appBackgroundColor)
          ],
        ),
      ),
    );
  }


}
