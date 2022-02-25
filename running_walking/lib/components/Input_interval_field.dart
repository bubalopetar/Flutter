import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:running_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputIntervalField extends StatefulWidget {
  InputIntervalField({
    @required this.controller,
    @required this.icon,
    @required this.activity,
    @required this.timeType,
  });
  final IconData icon;
  final String activity;
  final TextEditingController controller;
  var timeType;
  @override
  _InputIntervalFieldState createState() => _InputIntervalFieldState();
}

class _InputIntervalFieldState extends State<InputIntervalField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kInputWidth,
      child: TextFormField(
        controller: widget.controller,
        style: kInputStyle,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(kInputLength)
        ],
        decoration: InputDecoration(
            helperStyle: kHelperStyle,
            helperText: 'Interval you want to ${widget.activity}.',
            suffix: GestureDetector(
              onTap: () async {
                setState(() {
                  widget.timeType = widget.timeType == timeType.minutes
                      ? timeType.seconds
                      : timeType.minutes;
                  widget.activity == 'run'
                      ? kRunningTimeType = widget.timeType
                      : kWalkingTimeType = widget.timeType;
                });

                final sharedPrefs = await SharedPreferences.getInstance();
                sharedPrefs.setString(
                    widget.activity, widget.timeType.toString());
              },
              child: Text(
                widget.timeType.toString().split('.')[1],
                style: kSufixStyle,
              ),
            ),
            icon: Icon(
              widget.icon,
              size: kIconSize,
              color: kIconCollor,
            )),
      ),
    );
  }
}
