import 'package:app/app/servicos/autorizacao.dart';
import 'package:app/app/servicos/banco_de_dados.dart';
import 'package:app/custom_widget/platform_alert_dialog.dart';
import 'package:app/custom_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model/estado.dart';

class EstadoPage extends StatelessWidget {

  Future<void> _encerraSessao(BuildContext context) async {
    try {
      final autenticacao = Provider.of<AutorizacaoBase>(context);
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

  Future<void> _cadastraEstado(BuildContext context) async {
    try {
      final bancoDeDados = Provider.of<BancoDeDados>(context);
      await bancoDeDados.cadastraEstado(
          Estado(nome: 'Alagoas', uf: 'AL', ativo: true));
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Ops! alguma coisa deu errado... :(',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Image.asset(
            'lib/assets/imagem/akolhe-logo-only.png',
            height: 40.0,
          ),
        ),
        title: Text('Estados'),
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
      body: _buildConteudo(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _cadastraEstado(context),
      ),
    );
  }

  Widget _buildConteudo(BuildContext context) {

    final bancoDeDados = Provider.of<BancoDeDados>(context);
    return StreamBuilder<List<Estado>>(
      stream: bancoDeDados.estadosStream(),
      builder: (context, instantaneo) {
        if (instantaneo.hasData) {
          final estados = instantaneo.data;
          final children = estados.map((estado) => Text(estado.nome)).toList();
          return ListView(children: children);
        }
        if (instantaneo.hasError) {
          return Center(child: Text('Parece que alguma coisa deu errado.... :('));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

}


