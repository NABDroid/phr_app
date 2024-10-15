import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phr_app/Models/UserInfo.dart';
import 'package:phr_app/Screens/Profile/MedicalHistoryScreen.dart';
import 'package:phr_app/Services/AuthServices.dart';
import '../../Components/Global.dart';
import '../../Components/HeadingText.dart';

class ProfilePanel extends StatefulWidget {
  const ProfilePanel({super.key});

  @override
  State<ProfilePanel> createState() => _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController firstSOS = TextEditingController();
  final TextEditingController secondSOS = TextEditingController();
  final TextEditingController thirdSOS = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDOB;

  ValueNotifier<bool> activeSubmitButton = ValueNotifier<bool>(true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController.text = (currentUserInfo.fullName == null)
        ? ""
        : currentUserInfo.fullName.toString();
    dateOfBirthController.text = (currentUserInfo.dateOfBirth == null)
        ? ""
        : currentUserInfo.dateOfBirth.toString().toString().split(" ")[0];
    emailController.text = (currentUserInfo.emailAddress == null)
        ? ""
        : currentUserInfo.emailAddress.toString();
    contactNoController.text = (currentUserInfo.contactNo == null)
        ? ""
        : currentUserInfo.contactNo.toString();
    addressController.text = (currentUserInfo.address == null)
        ? ""
        : currentUserInfo.address.toString();
    firstSOS.text = (currentUserInfo.firstSos == null)
        ? ""
        : currentUserInfo.firstSos.toString();
    secondSOS.text = (currentUserInfo.secondSos == null)
        ? ""
        : currentUserInfo.secondSos.toString();
    thirdSOS.text = (currentUserInfo.thirdSos == null)
        ? ""
        : currentUserInfo.thirdSos.toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    activeSubmitButton.dispose();
    fullNameController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    contactNoController.dispose();
    addressController.dispose();
    firstSOS.dispose();
    secondSOS.dispose();
    thirdSOS.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Image(
                  height: 100,
                  image: AssetImage('asset/userPhoto.png'),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: fullNameController,
                        style: detailsTextStyle,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: detailsTextStyle,
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          // hintStyle:
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '* Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: emailController,
                        style: detailsTextStyle,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: detailsTextStyle,
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          // hintStyle:
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '* Required';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value.trim())) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: contactNoController,
                        style: detailsTextStyle,
                        decoration: InputDecoration(
                          labelText: 'Contact no',
                          labelStyle: detailsTextStyle,
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          // hintStyle:
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '* Required';
                          }
                          if (value.length < 11) {
                            return 'at least 11 digits required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: addressController,
                        style: detailsTextStyle,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: detailsTextStyle,
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          // hintStyle:
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '* Required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.streetAddress,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: dateOfBirthController,
                        enabled: false,
                        style: detailsTextStyle,
                        decoration: InputDecoration(
                          labelText: 'Date of birth',
                          labelStyle: detailsTextStyle,
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                        ),
                        validator: (value) {
                          try {
                            if (value == null || value.isEmpty) {
                              return '* Required';
                            } else {
                              DateTime dob = DateTime.parse(value!);
                            }
                          } catch (e) {
                            return 'Date format should be (YYYY-MM-DD)';
                          }

                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        pickDate(context);
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: textColorDark,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: firstSOS,
                          style: detailsTextStyle,
                          decoration: InputDecoration(
                            labelText: 'First SOS',
                            labelStyle: detailsTextStyle,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: secondSOS,
                          style: detailsTextStyle,
                          decoration: InputDecoration(
                            labelText: 'Second SOS',
                            labelStyle: detailsTextStyle,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 16),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: thirdSOS,
                          style: detailsTextStyle,
                          decoration: InputDecoration(
                            labelText: 'Third SOS',
                            labelStyle: detailsTextStyle,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const MedicalHistoryScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DetailsText(
                                text: "Medical History",
                                textColor: textColorDark,
                                alignment: TextAlign.start,
                                fSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: DetailsText(
                          text: "Gender: ${currentUserInfo.gender}",
                          textColor: textColorDark,
                          alignment: TextAlign.start),
                    ),
                    Flexible(
                      child: DetailsText(
                          text: "Blood Group: ${currentUserInfo.bloodGroup}",
                          textColor: textColorDark,
                          alignment: TextAlign.start),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: ValueListenableBuilder<bool>(
                  valueListenable: activeSubmitButton,
                  builder: (context, value, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: themeColorDark),
                      onPressed: (value)
                          ? () async {
                              if (formKey.currentState!.validate()) {
                                activeSubmitButton.value = false;
                                await updateProfile();
                                activeSubmitButton.value = true;
                              }
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
        ),
      ],
    );
  }

  Future<void> pickDate(BuildContext context) async {
    selectedDOB ??= DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDOB ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDOB) {
      setState(() {
        selectedDOB = picked;
        dateOfBirthController.text = selectedDOB.toString().split(" ")[0];
      });
    }
  }

  updateProfile() async {
    String name = fullNameController.text.trim();
    String email = emailController.text.trim();
    String dateOfBirth = dateOfBirthController.text.trim();
    String contactNo = contactNoController.text.trim();
    String address = addressController.text.trim();
    String firstSos = firstSOS.text.trim();
    String secondSos = secondSOS.text.trim();
    String thirdSos = thirdSOS.text.trim();


    AuthServices authServices = AuthServices();

    UserInfo updatedUser =  await authServices.updateProfile(name, email, contactNo, address, firstSos, secondSos, thirdSos, dateOfBirth);
    if(updatedUser.userId != null){

      Fluttertoast.showToast(
          msg: 'Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {

      });
    }



  }

}
