import 'package:app/app/servicos/autorizacao.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.autenticacao});

  final AutorizacaoBase autenticacao;

  Future<void> _encerraSessao() async {
    try {
      await autenticacao.encerraSessao();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina Inicial'),
        actions: <Widget>[
          FlatButton(
            child: Text('Sair',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                )),
            onPressed: _encerraSessao,
          )
        ],
      ),
    );
  }
}
