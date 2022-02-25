import 'package:flutter/material.dart';

//  flutter build apk --split-per-abi

timeType kRunningTimeType = timeType.minutes;
timeType kWalkingTimeType = timeType.seconds;
int kInitialRun = 3;
int kInitialWalk = 60;
var kAppTheme = ThemeData.light().copyWith(primaryColor: Colors.red);
enum activity { running, walking, paused }
enum timeType { seconds, minutes }
const kInputLength = 5;
const kMainPadding = EdgeInsets.fromLTRB(20, 0, 20, 0);
const kSufixStyle = TextStyle(fontSize: 25.0);
const kIconSize = 50.0;
const kIconCollor = Colors.red;
const kHelperStyle = TextStyle(fontSize: 18);
const kInputStyle = TextStyle(fontSize: 30);
const kTitleStyle = TextStyle(fontSize: 20, color: Colors.white);
const kStopWatchStyle = TextStyle(fontSize: 50);
const kStartButton = TextStyle(fontSize: 20, color: Colors.white);
const kAlertDialog = TextStyle(fontSize: 20, color: Colors.white);
const kInputWidth = 300.0;
const kAlertDialogText = TextStyle(fontSize: 20, color: Colors.black);
const kAlertDialogColor = Colors.white;
//const kAlertDialogPadding = EdgeInsets.fromLTRB(10, 10, 10, 10);
const kRunWalkStyle = TextStyle(fontSize: 25.0);
const kStopWatchElementsSpacing = 20.0;
const kStopWatchPadding = EdgeInsets.fromLTRB(0, 20, 0, 20);
const kFromTime = TextStyle(fontSize: 25, color: Colors.grey);
const kSetsStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red);
ShapeBorder kStartButtonShape = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.circular(50),
    side: BorderSide(color: Colors.white));
Icon kStopIcon = Icon(
  Icons.stop,
  color: Colors.red,
  size: 60.0,
);
Icon kStartIcon = Icon(
  Icons.arrow_right,
  color: Colors.green,
  size: 60.0,
);
Icon kLightIcon = Icon(
  Icons.lightbulb_outline,
  color: Colors.yellow,
);
