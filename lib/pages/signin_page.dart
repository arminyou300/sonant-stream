import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sonant_stream/constants.dart';
import 'package:sonant_stream/pages/home_page.dart';
import 'package:toastification/toastification.dart';

import '../widgets/pretty_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool passValidate = false;
  bool emailValidate = false;
  String emailError = '';
  String passError = '';
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            if (mounted) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: kDarkBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.login_rounded,
                color: Colors.white,
                size: 80,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Sign In using email and password',
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
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 50,
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
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    setState(() {
                      isPressed = true;
                    });
                    try {
                      await auth
                          .signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                          .then((value) {
                        if (kDebugMode) {
                          print(value);
                        }
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const HomePage(),
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
                      setState(() {
                        isPressed = false;
                      });
                      if (e.code == 'invalid-credential') {
                        if (context.mounted) {
                          toastification.show(
                            alignment: Alignment.bottomCenter,
                            foregroundColor: Colors.white,
                            closeOnClick: true,
                            title: const Text(
                              "Invalid credentials",
                            ),
                            closeButtonShowType: CloseButtonShowType.none,
                            type: ToastificationType.error,
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
                  }
                },
                child: isPressed == false
                    ? const Text(
                        'Login',
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'Lato,'),
                      )
                    : const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
