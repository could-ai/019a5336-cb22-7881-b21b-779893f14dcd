import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  // Mock list of Bluetooth devices
  final List<String> devices = [
    'Earbud A',
    'Earbud B',
    'Speaker',
    'Headphones',
  ];
  final List<String> selectedDevices = [];

  bool isPlaying = false;
  late AudioPlayer audioPlayer;
  final String audioUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void toggleSelection(String device) {
    setState(() {
      if (selectedDevices.contains(device)) {
        selectedDevices.remove(device);
      } else {
        if (selectedDevices.length < 2) {
          selectedDevices.add(device);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('只能选择两个设备')),
          );
        }
      }
    });
  }

  Future<void> playPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      // Play audio from URL. For audioplayers v0.20.1, use play(String url).
      await audioPlayer.play(audioUrl);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select up to 2 Bluetooth devices:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  final selected = selectedDevices.contains(device);
                  return ListTile(
                    leading: Checkbox(
                      value: selected,
                      onChanged: (_) => toggleSelection(device),
                    ),
                    title: Text(device),
                    onTap: () => toggleSelection(device),
                  );
                },
              ),
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: selectedDevices.isEmpty ? null : playPause,
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    label: Text(isPlaying ? 'Pause' : 'Play'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    selectedDevices.isEmpty
                        ? 'No devices selected'
                        : 'Playing on: ${selectedDevices.join(', ')}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
