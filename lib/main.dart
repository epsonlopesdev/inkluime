import 'package:app/app/seguranca/valida_usuario_page.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:app/app/servicos/autorizacao_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Inkluime());
}

class Inkluime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutorizacaoProvider(
      autorizacao: Autorizacao(),
      child: MaterialApp(
        title: 'Inlui.me',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: ValidaUsuario(),
      ),
    );
  }
}
