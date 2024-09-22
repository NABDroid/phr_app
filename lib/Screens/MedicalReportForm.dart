import 'package:flutter/material.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:phr_app/Services/RegistrationServices.dart';

import '../Components/Global.dart';

class MedicalReportForm extends StatefulWidget {
  const MedicalReportForm({super.key});

  @override
  State<MedicalReportForm> createState() => _MedicalReportFormState();
}

class _MedicalReportFormState extends State<MedicalReportForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RegistrationServices registrationServices = RegistrationServices();
    registrationServices.fetchHistoryTitles();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: backgroundImage,
              fit: BoxFit.cover, // Use BoxFit.cover to fill the entire screen
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 20,
                ),
                Headingtext(
                    text: "Medical Report Form",
                    textColor: textColorDark,
                    alignment: TextAlign.center),
                SizedBox(
                  height: 10,
                ),
                DetailsText(
                    text: "Name: ",
                    textColor: textColorDark,
                    alignment: TextAlign.start),
                DetailsText(
                    text: "Age: ",
                    textColor: textColorDark,
                    alignment: TextAlign.start),
                DetailsText(
                    text: "Blood group: ",
                    textColor: textColorDark,
                    alignment: TextAlign.start),
                DetailsText(
                    text: "Gender: ",
                    textColor: textColorDark,
                    alignment: TextAlign.start),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    Flexible(child: DetailsText(text: "Breathing Problem",textColor: textColorDark,alignment: TextAlign.start,))
                  ],
                ),





              ],
            ),
          )
        ],
      ),
    );
  }
}
