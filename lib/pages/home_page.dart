import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sonant_stream/constants.dart';
import 'package:sonant_stream/pages/music_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 50.0,
              floating: false,
              pinned: false,
              backgroundColor: Colors.transparent,
              title: Text(
                'Welcome ${auth.currentUser?.displayName}!',
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: auth.currentUser?.photoURL != null
                      ? Image.network(
                          '${auth.currentUser?.photoURL}',
                          fit: BoxFit.fill,
                        )
                      : const Icon(
                          Icons.person_2,
                          color: Colors.white,
                        ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              auth.currentUser!.displayName.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              auth.currentUser!.email.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                await auth.signOut();
              },
              child: const Text(
                'LogOut',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LyricPage(
                      songUrl:
                          'https://firebasestorage.googleapis.com/v0/b/soundify-b7297.appspot.com/o/musics%2FMaster%20of%20Puppets%2FMaster%20Of%20Puppets%20(Remastered)%20-%20Metallica%20(320).mp3?alt=media&token=763c80c4-00f1-4fff-a2df-4c7491f6164b',
                      lrcUrl:
                          'https://firebasestorage.googleapis.com/v0/b/soundify-b7297.appspot.com/o/musics%2FMaster%20of%20Puppets%2FMetallica%20-%20Master%20of%20Puppets.lrc?alt=media&token=3323250f-0761-4f8d-968d-070ed46641cd',
                    ),
                  ),
                );
              },
              child: const Text(
                'music',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
