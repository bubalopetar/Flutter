import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class AppSettings {
  Brightness brightness = Brightness.light;
  // var kRunningTimeType = timeType.minutes;
  // var kWalkingTimeType = timeType.seconds;

  void loadSavedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //print('brightness => ' + prefs.get('brightness'));
    //print('run => ' + prefs.get('run'));
    //print('walk => ' + prefs.get('walk'));
    //print('running_interval => ' + prefs.get('running_interval').toString());
    //print('walking_interval => ' + prefs.get('walking_interval').toString());

    if (prefs.containsKey('brightness')) {
      this.brightness =
          (prefs.getString("brightness") == Brightness.dark.toString())
              ? Brightness.dark
              : Brightness.light;
    }
    if (prefs.containsKey('run')) {
      kRunningTimeType = prefs.getString('run') == timeType.minutes.toString()
          ? timeType.minutes
          : timeType.seconds;
    }
    if (prefs.containsKey('walk')) {
      kWalkingTimeType = prefs.getString('walk') == timeType.minutes.toString()
          ? timeType.minutes
          : timeType.seconds;
    }
    if (prefs.containsKey('running_interval')) {
      if (kRunningTimeType == timeType.minutes) {
        kInitialRun = (prefs.get('running_interval') / 60).toInt();
      } else {
        kInitialRun = (prefs.get('running_interval')).toInt();
      }
    }
    if (prefs.containsKey('walking_interval')) {
      kInitialWalk = prefs.get('walking_interval');
      if (kWalkingTimeType == timeType.minutes) {
        kInitialWalk = (prefs.get('walking_interval') / 60).toInt();
      } else {
        kInitialWalk = (prefs.get('walking_interval')).toInt();
      }
    }
  }
}
