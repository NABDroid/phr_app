import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Components/Global.dart';
import '../Components/HeadingText.dart';



class SOSPanel extends StatefulWidget {
  const SOSPanel({super.key});

  @override
  State<SOSPanel> createState() => _SOSPanelState();
}


class _SOSPanelState extends State<SOSPanel> {
  final List<String> sosNumbers = ['999'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(currentUserInfo.firstSos !=null){
      sosNumbers.add(currentUserInfo.firstSos!);
    }
    if(currentUserInfo.secondSos !=null){
      sosNumbers.add(currentUserInfo.secondSos!);
    }
    if(currentUserInfo.thirdSos !=null){
      sosNumbers.add(currentUserInfo.thirdSos!);
    }
  }





  @override
  Widget build(BuildContext context) {

    void dialNumber(String number) async {
      final Uri telUri = Uri(scheme: 'tel', path: number);
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
        throw 'Could not launch $number';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: HeadingText(text: 'Hospital List', textColor: textColorLite,),
        backgroundColor: themeColorDark,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sosNumbers.map((number) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () => dialNumber(number),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColorDark,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: HeadingText(text: 'Call $number', textColor: textColorLite,),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
