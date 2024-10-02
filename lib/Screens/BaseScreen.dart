import 'package:flutter/material.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:phr_app/Screens/HomePanel.dart';
import 'package:phr_app/Screens/HospitalPanel.dart';
import 'package:phr_app/Screens/ProfilePanel.dart';
import 'package:phr_app/Screens/SOSPanel.dart';

import '../Components/Global.dart';
import 'Files/FilesPanel.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentDisplayedWidget = Container(height: 10,color: Colors.yellow);
    switch (currentScreen) {
      case 0:
        currentDisplayedWidget = HomePanel();
        break;
      case 1:
        currentDisplayedWidget = FilesPanel();
        break;
      case 2:
        currentDisplayedWidget = SOSPanel();
        break;
      case 3:
        currentDisplayedWidget = HospitalPanel();
        break;
      case 4:
        currentDisplayedWidget = ProfilePanel();
        break;
      default:
        currentDisplayedWidget = HomePanel();
    }


    return SafeArea(
      child: Scaffold(
        body: currentDisplayedWidget,
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
                icon: const Icon(Icons.home, size: 20),
                label: "Home",
                backgroundColor: appBackgroundColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.file_copy_sharp, size: 20),
                label: "Files",
                backgroundColor: appBackgroundColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.sos, color: Colors.redAccent, size: 30),
                label: "Emergency",
                backgroundColor: appBackgroundColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.local_hospital, size: 20),
                label: "Hospitals",
                backgroundColor: appBackgroundColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle, size: 20),
                label: "Profile",
                backgroundColor: appBackgroundColor),
          ],
        ),
      ),
    );
  }


  // Widget loadHome(){
  //   return Stack(
  //     children: [
  //       Positioned.fill(
  //         child: Image(
  //           image: backgroundImage,
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           children: [
  //             SizedBox(
  //               height: 120,
  //               child: Row(
  //                 children: [
  //                   const Image(
  //                     height: 100,
  //                     image: AssetImage('asset/userPhoto.png'),
  //                   ),
  //                   const SizedBox(
  //                     width: 15,
  //                   ),
  //                   Expanded(
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         DetailsText(
  //                             text: "Welcome",
  //                             textColor: textColorDark,
  //                             alignment: TextAlign.start),
  //                         HeadingText(
  //                             text: currentUserInfo.fullName!,
  //                             textColor: textColorDark,
  //                             alignment: TextAlign.start),
  //                       ],
  //                     ),
  //                   ),
  //                   const Icon(
  //                     Icons.notifications_none,
  //                     size: 40,
  //                     color: Colors.white,
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
  //               child: TextField(
  //                 controller: searchHospitalNameCont,
  //                 style: detailsTextStyle,
  //                 decoration: const InputDecoration(
  //                   hintText: 'Search',
  //                   prefixIcon: Icon(Icons.search),
  //                   focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(50)),
  //                       borderSide:
  //                       BorderSide(width: 2, color: Colors.black)),
  //                   border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(50)),
  //                       borderSide:
  //                       BorderSide(width: 1, color: Colors.black)),
  //                 ),
  //               ),
  //             ),
  //             Card(
  //               color: Colors.white10,
  //               child: SizedBox(
  //                 height: 50,
  //                 width: MediaQuery.of(context).size.width,
  //                 child: Center(child: DetailsText(text: "Search for hospital",textColor: textColorDark,alignment: TextAlign.center,)),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }



}
