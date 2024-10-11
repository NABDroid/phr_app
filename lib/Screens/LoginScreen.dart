import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:phr_app/Screens/BaseScreen.dart';
import 'package:phr_app/Screens/RegistrationScreen.dart';
import 'package:phr_app/Services/AuthServices.dart';
import '../Models/UserInfo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ValueNotifier<bool> activeLoginButton = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    activeLoginButton.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = 'maslinia.akij@gmail.com';
    passwordController.text = '123456';


    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Image(
                          height: 280,
                          width: 280,
                          image: AssetImage('asset/hospitalImage.png'),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextFormField(
                            controller: emailController,
                            style: detailsTextStyle,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
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
                            controller: passwordController,
                            style: detailsTextStyle,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: SizedBox(
                              height: 40,
                              child: ValueListenableBuilder<bool>(
                                valueListenable: activeLoginButton,
                                builder: (context, value, child) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: themeColorDark),
                                    onPressed: (value)
                                        ? () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              activeLoginButton.value = false;
                                              await loginProcess();
                                              activeLoginButton.value = true;
                                            }
                                          }
                                        : null,
                                    child: (value)
                                        ? DetailsText(
                                            text: "Login",
                                            textColor: textColorDark,
                                            alignment: TextAlign.start)
                                        : DetailsText(
                                            text: "Loading...",
                                            textColor: textColorDark,
                                            alignment: TextAlign.start),
                                  );
                                },
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()),
                              );
                            },
                            child: DetailsText(
                                text: "Don't have an account?",
                                textColor: textColorDark,
                                alignment: TextAlign.center),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).push(
            //           MaterialPageRoute(
            //               builder: (context) => const RegistrationScreen()),
            //         );
            //       },
            //       child: DetailsText(
            //           text: "Don't have an account?",
            //           textColor: textColorDark,
            //           alignment: TextAlign.center),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Future<void> loginProcess() async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    AuthServices loginService = AuthServices();

    UserInfo loginUser = await loginService.userLogin(email, password);
    if (loginUser.userId > 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BaseScreen()),
      );

      Fluttertoast.showToast(
          msg: 'Login successful.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: 'Wrong credential.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
