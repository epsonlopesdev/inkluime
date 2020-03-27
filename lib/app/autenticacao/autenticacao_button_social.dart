import 'package:app/custom_widget/custom_raised_button.dart';
import 'package:flutter/material.dart';

class AutenticacaoButtonSocial extends CustomRaisedButton {
  AutenticacaoButtonSocial({
    @required String icone,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) :  assert(icone != null),
        assert(text != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(icone),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15.0),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(icone),
              )
            ],
          ),
          color: color,
          height: 50.0,
          onPressed: onPressed,
        );
}
