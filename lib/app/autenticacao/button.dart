import 'package:app/custom_widget/raised_button.dart';
import 'package:flutter/material.dart';

class Button extends CustomRaisedButton {
  Button({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          height: 50.0,
          onPressed: onPressed,
        );
}
