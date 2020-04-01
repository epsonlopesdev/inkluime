import 'package:app/app/servicos/autorizacao.dart';
import 'package:flutter/material.dart';
import 'email_e_senha_form.dart';

class AutenticacaoComEmailESenhaPage extends StatelessWidget {
  AutenticacaoComEmailESenhaPage({@required this.autorizacao});
  final AutorizacaoBase autorizacao;
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
            child: EmailESenhaForm(autorizacao: autorizacao,),
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
