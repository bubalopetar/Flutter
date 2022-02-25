import 'package:running_app/constants.dart';
import 'package:flutter/material.dart';

class FieldErrorDialog extends StatelessWidget {
  const FieldErrorDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      color: kAlertDialogColor,
      //padding: kAlertDialogPadding,
      child: Text(
        'Please fill in all fields',
        textAlign: TextAlign.center,
        style: kAlertDialogText,
      ),
    ));
  }
}
