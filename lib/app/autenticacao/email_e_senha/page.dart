import 'package:flutter/material.dart';
import 'notifier.dart';

class ComEmailESenhaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar com E-mail e Senha'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailESenhaFormNotifier.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
