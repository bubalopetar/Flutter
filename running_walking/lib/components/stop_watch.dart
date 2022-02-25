import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:running_app/constants.dart';

class StopWatchWdg extends StatefulWidget {
  StopWatchWdg(
      {this.running, this.walking, this.stopwatch, this.elapsed, this.current});

  int running;
  int walking;
  Stopwatch stopwatch;
  Duration elapsed;
  var current;
  @override
  _StopWatchWdgState createState() => _StopWatchWdgState();
}

class _StopWatchWdgState extends State<StopWatchWdg> {
  Timer timer;
  int sets = 0;
  @override
  void initState() {
    // TODO: implement initState
    startStopWatch();
  }

  void startStopWatch() {
    AudioCache playMp3 = AudioCache();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (widget.stopwatch.isRunning) {
          setState(() {
            widget.elapsed = Duration(seconds: widget.elapsed.inSeconds + 1);

            if (widget.current == activity.running) {
              if (widget.elapsed.inSeconds == widget.running - 5 &&
                  widget.running > 5)
                playMp3.play(
                    'start_${widget.current == activity.running ? 'walking' : 'running'}.mp3');
              if (widget.elapsed.inSeconds == widget.running) {
                widget.elapsed = Duration(seconds: 0);
                widget.current = activity.walking;
              }
            } else if (widget.current == activity.walking) {
              if (widget.elapsed.inSeconds == widget.walking - 5 &&
                  widget.walking > 5)
                playMp3.play(
                    'start_${widget.current == activity.running ? 'walking' : 'running'}.mp3');
              if (widget.elapsed.inSeconds == widget.walking) {
                widget.elapsed = Duration(seconds: 0);
                sets += 1;
                widget.current = activity.running;
              }
            }
          });
        }
      });
    });
  }

  String formatDuration(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              '${widget.current == activity.running ? 'Running' : 'Walking'}',
              style: kRunWalkStyle,
            ),
            SizedBox(
              width: 50,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  sets = 0;
                });
              },
              child: Text(
                sets.toString() + ' sets',
                style: kSetsStyle,
              ),
            )
          ],
        ),
        Container(
          padding: kStopWatchPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                formatDuration(widget.stopwatch.elapsed),
                style: kStopWatchStyle,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (widget.stopwatch.isRunning)
                  widget.stopwatch.stop();
                else
                  widget.stopwatch.start();
              },
              child: widget.stopwatch.isRunning ? kStopIcon : kStartIcon,
            )
          ],
        ),
      ],
    );
  }
}

