import 'package:app/custom_widget/custom_raised_button.dart';
import 'package:flutter/material.dart';

class AutenticacaoButton extends CustomRaisedButton {
  AutenticacaoButton({
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
