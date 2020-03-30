import 'package:app/app/autenticacao/autenticacao_page.dart';
import 'package:app/app/home_page.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:flutter/material.dart';

class ValidaUsuario extends StatelessWidget {
  ValidaUsuario({@required this.autenticacao});

  final AutorizacaoBase autenticacao;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Usuario>(
        stream: autenticacao.autorizacaoAlterada,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            Usuario usuario = snapshot.data;
            if (usuario == null) {
              return AutenticacaoPage(
                autenticacao: autenticacao,
              );
            }

            return HomePage(
              autenticacao: autenticacao,
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
