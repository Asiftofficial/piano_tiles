import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:piano_tiles/moving_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piano Tiles test',
      home: MovingContainer(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _width = 70;
  double _height = 70;

  List<bool> _tileStatus = [
    false,
    false,
    false,
    false
  ]; // Keeps track of the tiles' statuses
  int _score = 0; // Keeps track of the user's score
  late AudioPlayer player; // Initializes the audio player

  // Plays a sound when a tile is tapped
  void _playSound() async {
    player.play();
  }

  // Handles a tile tap
  void _handleTap(int index) {
    setState(() {
      // Plays a sound and updates the tile's status
      if (!_tileStatus[index]) {
        _playSound();
        _tileStatus[index] = true;
        _score++;
      }
    });
  }

  // Builds the tiles
  List<Widget> _buildTiles() {
    return List.generate(
      4,
      (index) => GestureDetector(
        onTap: () => _handleTap(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          color: _tileStatus[index] ? Colors.black : Colors.blue,
          height: _height,
          width: _width,
        ),
      ),
    );
  }

  @override
  void initState() async {
    super.initState();
    await player.setAsset('assets/audio/beep.mp3');
    player = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Piano Tiles'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildTiles(),
            ),
            SizedBox(height: 20),
            Text(
              'Score: $_score',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
