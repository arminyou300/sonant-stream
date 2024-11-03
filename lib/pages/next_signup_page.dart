import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sonant_stream/pages/home_page.dart';

import '../constants.dart';
import '../widgets/pretty_textfield.dart';

class NextSignupPage extends StatefulWidget {
  const NextSignupPage({
    super.key,
    required this.email,
    required this.pass,
  });

  final String email;
  final String pass;

  @override
  State<NextSignupPage> createState() => _NextSignupPageState();
}

class _NextSignupPageState extends State<NextSignupPage> {
  TextEditingController displayNameController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  var firebaseFirestore = FirebaseFirestore.instance.collection('users');

  bool isPressed = false;

  Future<void> createUserDoc() async {
    if (auth.currentUser != null) {
      Map<String, dynamic> data = {
        'createdAt': Timestamp.now(),
        'email': auth.currentUser?.email,
        'enabled': true,
        'profilePictureUrl': '',
        'uid': auth.currentUser?.uid,
      };
      firebaseFirestore.add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_2_outlined,
            color: Colors.white,
            size: 90,
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'Enter your display name',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          PrettyTextField(
            controller: displayNameController,
            errorText: '',
            labelText: 'Display name',
            fieldColor: Colors.white,
            hiddenText: false,
            isEmail: false,
            borderColor: kMainColor,
            width: 350,
            height: 60,
            maxLength: 30,
            onChanged: () {},
            validate: false,
          ),
          const SizedBox(
            height: 70,
          ),
          ElevatedButton(
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
              await createUserDoc();
              await FirebaseAuth.instance.currentUser
                  ?.updateDisplayName(displayNameController.text)
                  .then(
                (value) {
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HomePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  }
                },
              );
            },
            child: isPressed == false
                ? const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                      fontSize: 18,
                    ),
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
    );
  }
}
