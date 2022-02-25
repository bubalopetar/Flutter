import 'package:flutter/material.dart';
import 'package:running_app/constants.dart';

class StartButton extends StatelessWidget {
  StartButton({@required this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        color: Colors.red,
        onPressed: onPressed,
        shape: kStartButtonShape,
        child: Text(
          'Start your excercise!',
          style: kStartButton,
        ),
      ),
    );
  }
}
