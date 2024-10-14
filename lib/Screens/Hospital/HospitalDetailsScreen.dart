import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:phr_app/Screens/Hospital/AmbulanceListScreen.dart';
import 'package:phr_app/Screens/Hospital/DoctorsListScreen.dart';
import 'package:phr_app/Services/HospitalServices.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Components/Global.dart';
import '../../Components/HeadingText.dart';


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

          unselectedItemColor: themeColorLite,
          unselectedLabelStyle: TextStyle(fontFamily: defaultFont),

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
                icon: SvgPicture.asset(
                  "asset/ambulanceIcon.svg",
                  height: currentScreen == 0 ? 30 : 20,
                  color: currentScreen == 0 ? textColorDark : Colors.grey,
                ),
                label: "Ambulances",),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                    "asset/doctorIcon.svg",
                    height: currentScreen == 1 ? 30 : 20,
                  color: currentScreen == 1 ? textColorDark : Colors.grey,
                ),
                label: "Doctors",),

          ],
        ),
      ),
    );
  }


}
