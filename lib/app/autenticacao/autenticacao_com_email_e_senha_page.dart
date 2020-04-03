import 'package:flutter/material.dart';
import 'email_e_senha_form.dart';

class AutenticacaoComEmailESenhaPage extends StatelessWidget {
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
            child: EmailESenhaForm(),
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
