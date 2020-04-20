import 'package:app/app/administracao/estado/estado_page.dart';
import 'package:app/app/administracao/estado/lista_de_itens_builder.dart';
import 'package:app/app/administracao/estado/lista_tile.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:app/app/servicos/banco_de_dados.dart';
import 'package:app/custom_widget/platform_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model/estado.dart';

class VisualizaEstadoPage extends StatelessWidget {
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

  Future<void> _exclui(BuildContext context, Estado estado) async {
    try{
      final bancoDeDados = Provider.of<BancoDeDados>(context);
      await bancoDeDados.excluiEstado(estado);
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Algo deu errado... :(',
        content: 'Não foi possivel excluir o estado.',
        defaultActionText: 'Fechar',
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
        onPressed: () => EstadoPage.exibir(context),
      ),
    );
  }

  Widget _buildConteudo(BuildContext context) {
    final bancoDeDados = Provider.of<BancoDeDados>(context);
    return StreamBuilder<List<Estado>>(
      stream: bancoDeDados.estadosStream(),
      builder: (context, instantaneo) {
        return ListItemsBuilder<Estado>(
            snapshot: instantaneo,
            itemBuilder: (context, estado) => Dismissible(
              background: Container(color: Colors.red,),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _exclui(context, estado),
              key: Key('estado-${estado.estadoId}'),
              child: ListaTileDeEstado(
                    estado: estado,
                    aoClicar: () => EstadoPage.exibir(context, estado: estado),
                  ),
            ),
        );
      },
    );
  }

}
