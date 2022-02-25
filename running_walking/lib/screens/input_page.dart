import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_app/constants.dart';
import '../components/Input_interval_field.dart';
import '../components/start_button.dart';
import 'package:running_app/settings.dart';
import '../components/stop_watch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatefulWidget {
  InputPage({this.changeTheme, this.settings});
  Function changeTheme;
  AppSettings settings;
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  void initState() {
    super.initState();
    // Start listening to changes.
    runningController.addListener(_updateValues);
    walkingController.addListener(_updateValues);
  }

  int _toSeconds(int time, activity activityType) {
    if (activityType == activity.running) {
      // if running input is in seconds
      if (kRunningTimeType == timeType.seconds)
        return time;
      //if running input is in minutes
      else
        return time * 60;
    } else {
      //if walking input is in seconds
      if (kWalkingTimeType == timeType.seconds)
        return time;
      //if walking input is in minutes
      else
        return time * 60;
    }
  }

  _updateValues() async {
    running = _toSeconds(int.parse(runningController.text), activity.running);
    walking = _toSeconds(int.parse(walkingController.text), activity.walking);
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setInt('running_interval', running);
    sharedPrefs.setInt('walking_interval', walking);
  }

  TextEditingController runningController =
      new TextEditingController(text: kInitialRun.toString());

  TextEditingController walkingController =
      new TextEditingController(text: kInitialWalk.toString());

  var running = kRunningTimeType == timeType.minutes
      ? int.parse(kInitialRun.toString()) * 60
      : int.parse(kInitialRun.toString());
  var walking = kWalkingTimeType == timeType.minutes
      ? int.parse(kInitialWalk.toString()) * 60
      : int.parse(kInitialWalk.toString());
  var activityStarted = false;
  Stopwatch stopwatch = Stopwatch();
  Duration elapsed = Duration(seconds: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Running / Walking intervals',
              style: kTitleStyle,
            ),
            GestureDetector(onTap: widget.changeTheme, child: kLightIcon),
          ],
        ),
      ),
      body: Container(
        padding: kMainPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InputIntervalField(
              controller: runningController,
              icon: Icons.directions_run,
              activity: 'run',
              timeType: kRunningTimeType,
            ),
            InputIntervalField(
              controller: walkingController,
              icon: Icons.directions_walk,
              activity: 'walk',
              timeType: kWalkingTimeType,
            ),
            StartButton(
              onPressed: () {
                // to hide keyboard
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                setState(() {
                  if (activityStarted) {
                    stopwatch.reset();
                    stopwatch.start();
                    elapsed = Duration(seconds: -1);
                  } else {
                    stopwatch.start();
                    activityStarted = true;
                  }
                });
              },
            ),
            activityStarted
                ? StopWatchWdg(
                    running: running,
                    walking: walking,
                    stopwatch: stopwatch,
                    elapsed: elapsed,
                    current: activity.running,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
