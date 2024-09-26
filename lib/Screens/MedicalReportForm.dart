import 'package:flutter/material.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:phr_app/Models/HistoryTitles.dart';
import 'package:phr_app/Services/RegistrationServices.dart';
import '../Components/Global.dart';

class MedicalReportForm extends StatefulWidget {
  MedicalReportForm({super.key, required this.userName, required this.password, required this.email, required this.userDOB});
  final String userName, password, email;
  final DateTime userDOB;

  @override
  State<MedicalReportForm> createState() => _MedicalReportFormState();
}

class _MedicalReportFormState extends State<MedicalReportForm> {
  List<HistoryTitle> titles = [];
  String gender = "Select gender";
  String bloodGroup = "Select blood group";
  String age = "";

  @override
  void initState() {
    super.initState();
    loadHistoryTitles();

    Duration timeDifference = DateTime.now().difference(widget.userDOB);

    int years = timeDifference.inDays~/365;
    int months = (timeDifference.inDays - years*365)~/30;
    age = "$years ${(years>1)?"years":"year"} and $months ${(months>1)?"months":"month"}";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Stack(
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
                const SizedBox(
                  height: 20,
                ),
                Headingtext(
                    text: "Medical Report Form",
                    textColor: textColorDark,
                    alignment: TextAlign.center),
                const SizedBox(
                  height: 10,
                ),
                DetailsText(
                    text: "Name: ${widget.userName}",
                    textColor: textColorDark,
                    alignment: TextAlign.start),
                const SizedBox(
                  height: 5,
                ),
                DetailsText(
                    text: "Age: $age",
                    textColor: textColorDark,
                    alignment: TextAlign.start),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    DetailsText(
                        text: "Blood Group: ",
                        textColor: textColorDark,
                        alignment: TextAlign.start),
                    Flexible(child: DropdownButton<String>(
                      value: bloodGroup,
                      isExpanded: true,
                      items: <String>['Select blood group', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: detailsTextStyle,),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          bloodGroup = newValue!;
                        });
                      },
                    ))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    DetailsText(
                        text: "Gender: ",
                        textColor: textColorDark,
                        alignment: TextAlign.start),
                    Flexible(child: DropdownButton<String>(
                      value: gender,
                      isExpanded: true,
                      items: <String>['Select gender', 'Male', 'Female', 'Third'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: detailsTextStyle,),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                    ))
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Checkbox(
                            value: titles[index].isChecked,
                            onChanged: (bool? value) {
                              titles[index].isChecked = (value!=null)?value:false;
                              setState(() {

                              });
                            },
                          ),
                          Flexible(child: DetailsText(text: titles[index].title,
                            textColor: textColorDark,
                            alignment: TextAlign.start,))
                        ],
                      );
                    },
                  ),
                )


              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> loadHistoryTitles() async {
    RegistrationServices registrationServices = RegistrationServices();
    titles = await registrationServices.fetchHistoryTitles();
    if (titles.length > 0) {
      setState(() {
      });
    }
  }
}
