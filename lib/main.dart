import 'package:app/app/autenticacao/autenticacao_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Inkluime());
}

class Inkluime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inlui.me',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: AutenticacaoPage(),
    );
  }
}
