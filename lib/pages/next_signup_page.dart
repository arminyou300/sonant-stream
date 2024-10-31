import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/pretty_textfield.dart';

class NextSignupPage extends StatefulWidget {
  const NextSignupPage({super.key});

  @override
  State<NextSignupPage> createState() => _NextSignupPageState();
}

class _NextSignupPageState extends State<NextSignupPage> {
  TextEditingController displaynameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            height: 80,
          ),
          PrettyTextField(
            controller: displaynameController,
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
          ElevatedButton.icon(
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(10),
              backgroundColor: WidgetStatePropertyAll(kMainColor),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {

            },
            label: const Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
