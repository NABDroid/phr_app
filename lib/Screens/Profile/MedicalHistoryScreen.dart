import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phr_app/Services/HospitalServices.dart';

import '../../Components/Global.dart';
import '../../Components/HeadingText.dart';
import '../../Models/HistoryTitles.dart';
import '../../Models/MedicalHistory.dart';
import '../../Services/AuthServices.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  List<HistoryTitle> titles = [];
  ValueNotifier<bool> activeSubmitButton = ValueNotifier<bool>(true);

  Future<void> loadHistoryTitles() async {
    AuthServices registrationServices = AuthServices();
    titles = await registrationServices.getUserMedicalHistory();
    if (titles.length > 0) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHistoryTitles();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: HeadingText(
            text: 'Medical History',
            textColor: textColorLite,
          ),
          backgroundColor: themeColorDark,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                              text:titles[index].title,
                              textColor: textColorDark,
                              alignment: TextAlign.start,
                            ))
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: activeSubmitButton,
                    builder: (context, value, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: themeColorDark),
                        onPressed: (value)
                            ? () async {
                                activeSubmitButton.value = false;
                                await submitHistoryChange();
                                activeSubmitButton.value = true;
                              }
                            : null,
                        child: (value)
                            ? DetailsText(
                                text: "Update",
                                textColor: textColorDark,
                                alignment: TextAlign.start)
                            : DetailsText(
                                text: "Loading...",
                                textColor: textColorDark,
                                alignment: TextAlign.start),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  submitHistoryChange() async {
    HospitalServices hospitalServices = HospitalServices();

    List<MedicalHistory> medicalHistories = [];
    for (int i = 0; i < titles.length; i++) {
      if (titles[i].historyId != null) {
        MedicalHistory medicalHistory = MedicalHistory(
            historyId: titles[i].historyId!,
            userId: currentUserInfo.userId,
            titleId: titles[i].titleId,
            isTrue: titles[i].isChecked,
            remarks: "Updated from profile",
            isActive: true);
        medicalHistories.add(medicalHistory);
      }
    }
    bool isUpdated =
        await hospitalServices.updatePatientHistory(medicalHistories);
    if(isUpdated){
      Fluttertoast.showToast(
          msg: 'Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }


  }
}
