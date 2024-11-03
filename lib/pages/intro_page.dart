import 'package:flutter/material.dart';
import 'package:sonant_stream/constants.dart';
import 'package:sonant_stream/pages/signin_page.dart';
import 'package:sonant_stream/pages/signup_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kBoxColor,
              kMainColor,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo.png',
              color: Colors.white,
              width: 250,
              height: 250,
            ),
            const Text(
              'Listen to musics unlimitedly.',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Nexa',
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(kBoxColor),
                  elevation: const WidgetStatePropertyAll(10),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    DialogRoute(
                      context: context,
                      builder: (context) => const SignupPage(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  elevation: const WidgetStatePropertyAll(0),
                  side: const WidgetStatePropertyAll(
                    BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    DialogRoute(
                      context: context,
                      builder: (context) => const SignInPage(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nexa',
                      fontWeight: FontWeight.w100,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
