import 'package:app/custom_widget/custom_raised_button.dart';
import 'package:flutter/material.dart';

class CustomSubmitButtom extends CustomRaisedButton {
  CustomSubmitButtom({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
    height: 44.0,
    color: Colors.blueGrey,
    onPressed: onPressed,
        );
}
