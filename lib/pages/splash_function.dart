import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sonant_stream/pages/home_page.dart';
import 'package:sonant_stream/pages/intro_page.dart';

class SplashFunction extends StatelessWidget {
  const SplashFunction({super.key});

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Firebase Initialization Failed: ${snapshot.error}'));
        }
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.hasData) {
              return const HomePage();
            } else {
              return const IntroPage();
            }
          },
        );
      },
    );
  }
}
