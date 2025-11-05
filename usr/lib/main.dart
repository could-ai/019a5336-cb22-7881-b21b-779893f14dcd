import 'package:flutter/material.dart';
import 'screens/music_player_page.dart';

void main() {
  runApp(const MusicPlayerApp());
}

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MusicPlayerPage(),
      // Ensure default route is registered
      routes: {
        '/': (context) => const MusicPlayerPage(),
      },
    );
  }
}
