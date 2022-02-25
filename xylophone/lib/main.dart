import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void playsound(int a) {
    final player = AudioCache();
    player.play('note$a.wav');
  }

  Expanded buildKey({int number, Color color}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: color),
        onPressed: () {
          playsound(number);
        },
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKey(number: 1, color: Colors.red),
              buildKey(number: 2, color: Colors.yellow),
              buildKey(number: 3, color: Colors.orange),
              buildKey(number: 4, color: Colors.blue),
              buildKey(number: 5, color: Colors.teal),
              buildKey(number: 6, color: Colors.green),
              buildKey(number: 7, color: Colors.tealAccent),
            ],
          ),
        ),
      ),
    );
  }
}
