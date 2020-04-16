import 'package:app/app/autenticacao/page.dart';
import 'package:app/app/home/page.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ValidaUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final autenticacao = Provider.of<AutorizacaoBase>(context);
    return StreamBuilder<Usuario>(
        stream: autenticacao.autorizacaoAlterada,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            Usuario usuario = snapshot.data;
            if (usuario == null) {
              return AutenticacaoPage.create(context);
            }
            return HomePage();
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
