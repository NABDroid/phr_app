import 'package:flutter/material.dart';
import '../../Components/Global.dart';
import '../../Components/HeadingText.dart';
import 'LoginScreen.dart';
import 'MedicalReportForm.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reTypeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDOB;


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    contactNoController.dispose();
    addressController.dispose();
    passwordController.dispose();
    reTypeController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: backgroundImage,
                fit: BoxFit.cover, // Use BoxFit.cover to fill the entire screen
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
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
                              controller: firstNameController,
                              style: detailsTextStyle,
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                labelStyle: detailsTextStyle,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black)),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black)),
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
                              controller: lastNameController,
                              style: detailsTextStyle,
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                labelStyle: detailsTextStyle,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black)),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black)),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                          if (value.length<11) {
                            return 'at least 11 digits required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                        keyboardType: TextInputType.streetAddress,

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
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.black)),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black)),
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
                      child: TextFormField(
                        controller: passwordController,
                        style: detailsTextStyle,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: detailsTextStyle,
                          border: const OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.trim().length < 6) {
                            return 'Password must contain at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                        controller: reTypeController,
                        style: detailsTextStyle,
                        decoration: InputDecoration(
                          labelText: 'Re-Type Password',
                          labelStyle: detailsTextStyle,
                          border: const OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.trim() !=
                              passwordController.text.trim()) {
                            return "Password didn't matched";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: themeColorDark),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            String fullName = firstNameController.text.trim() +
                                " " +
                                lastNameController.text.trim();
                            DateTime userDOB = DateTime.parse(
                                dateOfBirthController.text.trim());
                            String email = emailController.text.trim();
                            String contactNo = contactNoController.text.trim();
                            String address = addressController.text.trim();
                            String password = passwordController.text.trim();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MedicalReportForm(
                                      fullName: fullName,
                                      password: password,
                                      email: email,
                                      contactNo: contactNo,
                                      address: address,
                                      userDOB: userDOB)),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DetailsText(
                              text: "Register",
                              textColor: textColorDark,
                              alignment: TextAlign.start),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: DetailsText(
                            text: "Already have an account?",
                            textColor: textColorDark,
                            alignment: TextAlign.center),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
    if (picked != null && picked != selectedDOB)
      setState(() {
        selectedDOB = picked;
        dateOfBirthController.text = selectedDOB.toString().split(" ")[0];
      });
  }
}
