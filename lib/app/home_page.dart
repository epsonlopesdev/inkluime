import 'package:app/app/servicos/autorizacao_provider.dart';
import 'package:app/custom_widget/platform_alert_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  Future<void> _encerraSessao(BuildContext context) async {
    try {
      final autenticacao = AutorizacaoProvider.of(context);
      await autenticacao.encerraSessao();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmaEncerraSessao(BuildContext context) async {
    final encerramentoDaSessao = await PlatformAlertDialog(
      title: 'Sair',
      content: 'Deseja realmente sair?',
      cancelActionText: 'Não',
      defaultActionText: 'Sim',
    ).show(context);
    if (encerramentoDaSessao == true) {
      _encerraSessao(context);
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
            onPressed: () => _confirmaEncerraSessao(context),
          )
        ],
      ),
    );
  }
}
