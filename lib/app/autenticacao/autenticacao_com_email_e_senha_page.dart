import 'package:app/app/autenticacao/autenticacao_com_email_e_senha_base.dart';
import 'package:flutter/material.dart';

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
            child: EmailESenhaFormBlocBase.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
