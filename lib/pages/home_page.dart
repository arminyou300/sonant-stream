import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sonant_stream/constants.dart';
import 'package:sonant_stream/pages/music_page.dart';
import 'package:sonant_stream/widgets/bottom_bar.dart';
import 'package:sonant_stream/widgets/music_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var musics = FirebaseFirestore.instance.collection('musics');
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackgroundColor,
      bottomNavigationBar: BottomBar(index: index),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    await auth.signOut();
                  },
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedLogout02,
                    color: Colors.white,
                  ),
                ),
              ],
              automaticallyImplyLeading: false,
            )
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: musics.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No music found'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var musicDoc = snapshot.data!.docs[index];
                      return MusicTile(musicUID: musicDoc.id);
                    },
                  ),
                );
              },
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => LyricPage(
            //           songUrl:
            //               'https://firebasestorage.googleapis.com/v0/b/soundify-b7297.appspot.com/o/musics%2FNada%20Nuevo%20Bajo%20El%20Sol%20(Album%20Version)%2F09%20Los%20Bunkers%20-%20Nada%20Nuevo%20Bajo%20El%20Sol%20(album%20Version).mp3?alt=media&token=711809c7-b26b-4e1d-ad11-d2a62f020366',
            //           lrcUrl:
            //               'https://firebasestorage.googleapis.com/v0/b/soundify-b7297.appspot.com/o/musics%2FNada%20Nuevo%20Bajo%20El%20Sol%20(Album%20Version)%2FLos%20Bunkers%20-%20Nada%20Nuevo%20Bajo%20El%20Sol.lrc?alt=media&token=fcb838e2-5963-493c-91ed-114ff9a674f3',
            //         ),
            //       ),
            //     );
            //   },
            //   child: const Text(
            //     'music',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
