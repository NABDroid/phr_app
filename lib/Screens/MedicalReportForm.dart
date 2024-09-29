import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:phr_app/Models/HistoryTitles.dart';
import 'package:phr_app/Models/MedicalHistory.dart';
import 'package:phr_app/Models/UserInfo.dart';
import 'package:phr_app/Screens/HomePage.dart';
import 'package:phr_app/Services/AuthServices.dart';
import '../Components/Global.dart';
import '../Models/RegisterDTO.dart';

class MedicalReportForm extends StatefulWidget {
  MedicalReportForm(
      {super.key,
      required this.fullName,
      required this.password,
      required this.email,
      required this.userDOB,
      required this.contactNo,
      required this.address});

  final String fullName, password, email, contactNo, address;
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

    int years = timeDifference.inDays ~/ 365;
    int months = (timeDifference.inDays - years * 365) ~/ 30;
    age =
        "$years ${(years > 1) ? "years" : "year"} and $months ${(months > 1) ? "months" : "month"}";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  HeadingText(
                      text: "Medical Report Form",
                      textColor: textColorDark,
                      alignment: TextAlign.center),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailsText(
                      text: "Name: ${widget.fullName}",
                      textColor: textColorDark,
                      alignment: TextAlign.start),
                  const SizedBox(height: 5),
                  DetailsText(
                      text: "Age: $age",
                      textColor: textColorDark,
                      alignment: TextAlign.start),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      DetailsText(
                          text: "Blood Group: ",
                          textColor: textColorDark,
                          alignment: TextAlign.start),
                      Flexible(
                          child: DropdownButton<String>(
                        value: bloodGroup,
                        isExpanded: true,
                        items: <String>[
                          'Select blood group',
                          'A+',
                          'A-',
                          'B+',
                          'B-',
                          'AB+',
                          'AB-',
                          'O+',
                          'O-'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: detailsTextStyle,
                            ),
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
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      DetailsText(
                          text: "Gender: ",
                          textColor: textColorDark,
                          alignment: TextAlign.start),
                      Flexible(
                          child: DropdownButton<String>(
                        value: gender,
                        isExpanded: true,
                        items: <String>[
                          'Select gender',
                          'Male',
                          'Female',
                          'Third'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: detailsTextStyle,
                            ),
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
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: titles.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Checkbox(
                              value: titles[index].isChecked,
                              onChanged: (bool? value) {
                                titles[index].isChecked =
                                    (value != null) ? value : false;
                                setState(() {});
                              },
                            ),
                            Flexible(
                                child: DetailsText(
                              text: titles[index].title,
                              textColor: textColorDark,
                              alignment: TextAlign.start,
                            ))
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: themeColorDark),
                      onPressed: () {
                        register();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DetailsText(
                            text: "Submit",
                            textColor: textColorDark,
                            alignment: TextAlign.start),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> loadHistoryTitles() async {
    AuthServices registrationServices = AuthServices();
    titles = await registrationServices.fetchHistoryTitles();
    if (titles.length > 0) {
      setState(() {});
    }
  }

  Future<void> register() async {
    int genderId = 1;
    if (gender == "Female") {
      genderId = 2;
    }

    RegisterDTO registerDTO = RegisterDTO(
        fullName: widget.fullName,
        emailAddress: widget.email,
        contactNo: widget.contactNo,
        address: widget.address,
        genderId: genderId,
        dateOfBirth: widget.userDOB,
        bloodGroup: bloodGroup,
        identificationNo: "",
        identificationTypeId: "",
        password: widget.password);
    AuthServices regService = AuthServices();
    UserInfo newUser = await regService.userRegister(registerDTO);
    if (newUser.userId > 0) {
      bool isHistoryAdded = false;
      if (titles.length > 0) {
        List<MedicalHistory> medicalHistories = [];
        for (int i = 0; i < titles.length; i++) {
          MedicalHistory medicalHistory = MedicalHistory(
              historyId: 0,
              userId: newUser.userId,
              titleId: titles[i].titleId,
              isTrue: titles[i].isChecked,
              remarks: "During registration",
              isActive: true);
          medicalHistories.add(medicalHistory);
        }
        isHistoryAdded = await regService.submitUserHistory(medicalHistories);
      }

      if (!isHistoryAdded) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
              Text('Registration successful but failed to save history')),
        );
        await Future.delayed(const Duration(seconds: 2));
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed')),
      );
    }
  }
}
