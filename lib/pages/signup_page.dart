import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sonant_stream/constants.dart';
import 'package:sonant_stream/pages/next_signup_page.dart';
import 'package:sonant_stream/widgets/pretty_textfield.dart';
import 'package:toastification/toastification.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  // var firebaseFirestore = FirebaseFirestore.instance.collection('user');

  bool validate1 = false;
  bool validate2 = false;
  bool validate3 = false;
  bool validate4 = false;
  bool passValidate = false;
  bool emailValidate = false;
  String emailError = '';
  String passError = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Future<void> createUserDoc() async {
  //   if (auth.currentUser != null) {
  //     Map<String, dynamic> data = {
  //
  //     };
  //     firebaseFirestore.add(data);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up using email and password',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              PrettyTextField(
                controller: emailController,
                errorText: emailError,
                labelText: 'Email',
                fieldColor: Colors.white,
                hiddenText: false,
                isEmail: true,
                borderColor: kMainColor,
                width: 350,
                height: 60,
                maxLength: 70,
                onChanged: (value) {},
                validate: emailValidate,
              ),
              const SizedBox(
                height: 50,
              ),
              PrettyTextField(
                controller: passwordController,
                errorText: passError,
                validate: passValidate,
                labelText: 'Password',
                fieldColor: Colors.white,
                hiddenText: true,
                isEmail: false,
                borderColor: kMainColor,
                width: 350,
                height: 60,
                maxLength: 30,
                onChanged: (value) {
                  if (RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                    setState(() {
                      validate1 = true;
                    });
                  } else {
                    setState(() {
                      validate1 = false;
                    });
                  }

                  if (RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
                    setState(() {
                      validate2 = true;
                    });
                  } else {
                    setState(() {
                      validate2 = false;
                    });
                  }

                  if (RegExp(r'^(?=.*[^A-Za-z0-9])').hasMatch(value)) {
                    setState(() {
                      validate3 = true;
                    });
                  } else {
                    setState(() {
                      validate3 = false;
                    });
                  }

                  if (RegExp(r'^(?=.*[0-9])').hasMatch(value)) {
                    setState(() {
                      validate4 = true;
                    });
                  } else {
                    setState(() {
                      validate4 = false;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          validate1 == false
                              ? Icons.circle_outlined
                              : Icons.check_circle,
                          color: Colors.green,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'One uppercase character',
                          style: TextStyle(
                            color: Colors.white38,
                            fontFamily: 'Lato',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          validate2 == false
                              ? Icons.circle_outlined
                              : Icons.check_circle,
                          color: Colors.green,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'One lowercase character',
                          style: TextStyle(
                            color: Colors.white38,
                            fontFamily: 'Lato',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          validate3 == false
                              ? Icons.circle_outlined
                              : Icons.check_circle,
                          color: Colors.green,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'One special character',
                          style: TextStyle(
                            color: Colors.white38,
                            fontFamily: 'Lato',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          validate4 == false
                              ? Icons.circle_outlined
                              : Icons.check_circle,
                          color: Colors.green,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'One numeric character',
                          style: TextStyle(
                            color: Colors.white38,
                            fontFamily: 'Lato',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                iconAlignment: IconAlignment.end,
                style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(10),
                  backgroundColor: WidgetStatePropertyAll(kMainColor),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (validate1 &&
                      validate2 &&
                      validate3 &&
                      validate4 &&
                      emailController.text.isNotEmpty) {
                    if (RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailController.text)) {
                      if (passwordController.text.length > 6) {
                        try {
                          await auth
                              .createUserWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          )
                              .then((value) {
                            if (kDebugMode) {
                              print(value);
                            }
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const NextSignupPage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: animation.drive(
                                        Tween(
                                          begin: const Offset(0, 1),
                                          end: Offset.zero,
                                        ),
                                      ),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            }
                          });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            if (context.mounted) {
                              toastification.show(
                                title: const Text(
                                  "The email you've entered is already in use",
                                ),
                                alignment: Alignment.bottomCenter,
                                foregroundColor: Colors.white,
                                closeOnClick: true,
                                closeButtonShowType: CloseButtonShowType.always,
                                type: ToastificationType.warning,
                                showProgressBar: false,
                                autoCloseDuration: const Duration(seconds: 5),
                                applyBlurEffect: true,
                                backgroundColor: kBoxColor,
                              );
                            }
                          } else {
                            if (kDebugMode) {
                              print('FirebaseAuthException: $e');
                            }
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print('Error: $e');
                          }
                        }
                        setState(() {
                          passError = '';
                          passValidate = false;
                          emailError = '';
                          emailValidate = false;
                        });
                      } else {
                        setState(() {
                          passError = 'Password should have 6 characters';
                          passValidate = true;
                        });
                      }
                    } else {
                      setState(() {
                        emailError = 'Email format is not correct';
                        emailValidate = true;
                      });
                    }
                  } else {
                    setState(() {
                      passError = 'Password should follow the password policy';
                      passValidate = true;
                      emailError = 'Email field cannot be empty';
                      emailValidate = true;
                    });
                  }
                },
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
