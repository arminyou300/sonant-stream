import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class LyricLine {
  final Duration time;
  final String line;

  LyricLine(this.time, this.line);
}

class LyricPage extends StatefulWidget {
  final String songUrl;
  final String lrcUrl;

  LyricPage({required this.songUrl, required this.lrcUrl});

  @override
  _LyricPageState createState() => _LyricPageState();
}

class _LyricPageState extends State<LyricPage> {
  final player = AudioPlayer();
  List<LyricLine> lyrics = [];
  int currentIndex = 0;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    await _loadLyricsFromUrl(widget.lrcUrl);
    await player.setUrl(widget.songUrl);

    // Listen to player position updates
    player.positionStream.listen((position) {
      _updateLyric(position);
    });
  }

  Future<void> _loadLyricsFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final lrcContent = utf8.decode(response.bodyBytes);
        lyrics = _parseLrcContent(lrcContent);
      } else {
        print("Failed to load lyrics: ${response.statusCode}");
      }
    } catch (e) {
      print("Error loading lyrics: $e");
    }
  }

  List<LyricLine> _parseLrcContent(String lrcContent) {
    final lines = lrcContent.split('\n');
    final regex = RegExp(r'\[(\d{2}):(\d{2})\.(\d{2})\](.*)');
    final parsedLyrics = <LyricLine>[];

    for (var line in lines) {
      final match = regex.firstMatch(line);
      if (match != null) {
        final minutes = int.parse(match.group(1)!);
        final seconds = int.parse(match.group(2)!);
        final milliseconds = int.parse(match.group(3)!);
        final text = match.group(4)?.trim() ?? "";

        final time = Duration(
            minutes: minutes, seconds: seconds, milliseconds: milliseconds);
        parsedLyrics.add(LyricLine(time, text));
      }
    }

    return parsedLyrics;
  }

  void _updateLyric(Duration position) {
    for (int i = 0; i < lyrics.length; i++) {
      if (position < lyrics[i].time) break;
      setState(() => currentIndex = i);
    }

    final offset = (currentIndex * 30.0) -
        (scrollController.position.viewportDimension / 4);
    scrollController.animateTo(
      offset.clamp(0.0, scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    player.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          widget.lrcUrl != ''
              ? Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: lyrics.length,
                    itemBuilder: (context, index) {
                      return Text(
                        lyrics[index].line,
                        style: TextStyle(
                          fontSize: 16,
                          color: index == currentIndex
                              ? Colors.blue
                              : Colors.black,
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text(
                    'We still don\'t know the lyrics',
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () => player.play(),
              ),
              IconButton(
                icon: const Icon(Icons.pause),
                onPressed: () => player.pause(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
