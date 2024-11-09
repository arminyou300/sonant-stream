import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sonant_stream/constants.dart';

class MusicTile extends StatefulWidget {
  const MusicTile({super.key, required this.musicUID});

  final String musicUID;

  @override
  State<MusicTile> createState() => _MusicTileState();
}

class _MusicTileState extends State<MusicTile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _firestore.collection('musics').doc(widget.musicUID).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: kMenuItemsColor,
              borderRadius: BorderRadius.circular(15),
            ),
            width: 80,
            height: 50,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const SizedBox.shrink();
        }

        Map<String, dynamic> musicData =
            snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: kMenuItemsColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: () {
              // Handle music selection
              // You can navigate to music player page here
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: musicData['cover_url'] != null
                          ? DecorationImage(
                              image: NetworkImage(musicData['cover_url']),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: musicData['cover_url'] == null
                        ? const Icon(
                            Icons.music_note,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  // Music Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          musicData['title'] ?? 'Unknown Title',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          musicData['artist'] ?? 'Unknown Artist',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Duration
                  // if (musicData['duration'] != null)
                  //   Text(
                  //     _formatDuration(musicData['duration']),
                  //     style: TextStyle(
                  //       color: Colors.white.withOpacity(0.7),
                  //       fontSize: 14,
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
