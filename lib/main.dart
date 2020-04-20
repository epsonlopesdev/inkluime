import 'package:app/app/seguranca/valida_usuario_page.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(Akolhe());
}

class Akolhe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AutorizacaoBase>(
      create: (context) => Autorizacao(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: ValidaUsuario(),
      ),
    );
  }
}
