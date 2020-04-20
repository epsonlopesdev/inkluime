import 'package:app/app/servicos/banco_de_dados.dart';
import 'package:app/custom_widget/platform_alert_dialog.dart';
import 'package:app/custom_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model/estado.dart';

class EstadoPage extends StatefulWidget {
  const EstadoPage({Key key, @required this.bancoDeDados, this.estado})
      : super(key: key);
  final BancoDeDados bancoDeDados;
  final Estado estado;

  static Future<void> exibir(BuildContext context, {Estado estado}) async {
    final bancoDeDados = Provider.of<BancoDeDados>(context);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EstadoPage(
        bancoDeDados: bancoDeDados,
        estado: estado,
      ),
      fullscreenDialog: true,
    ));
  }

  @override
  _EstadoPageState createState() => _EstadoPageState();
}

class _EstadoPageState extends State<EstadoPage> {
  final _formKey = GlobalKey<FormState>();
  String _nomeDoEstado;
  String _unidadeFederativa;

  @override
  void initState() {
    super.initState();
    if (widget.estado != null) {
      _nomeDoEstado = widget.estado.nomeDoEstado;
      _unidadeFederativa = widget.estado.unidadeFedarativa;
    }
  }

  bool _validaFomrularioESalva() {
    final formulario = _formKey.currentState;
    if (formulario.validate()) {
      formulario.save();
      return true;
    }
    return false;
  }

  Future<void> _enviar() async {
    if (_validaFomrularioESalva()) {
      try {
        final estados = await widget.bancoDeDados.estadosStream().first;
        final listaDeEstados =
            estados.map((estado) => estado.nomeDoEstado).toList();
        if (widget.estado != null) {
          listaDeEstados.remove(widget.estado.nomeDoEstado);
        }
        if (listaDeEstados.contains(_nomeDoEstado)) {
          PlatformAlertDialog(
            title: 'Estado já cadastrado',
            content: 'Por favor, informe um nome de estado diferente.',
            defaultActionText: 'Fechar',
          ).show(context);
        } else {
          final estadoId = widget.estado?.estadoId ?? gerarEstadoId();
          final estado = Estado(
            estadoId: estadoId,
            nomeDoEstado: _nomeDoEstado,
            unidadeFedarativa: _unidadeFederativa,
            estadoAtivo: true,
          );
          await widget.bancoDeDados.salvaEstado(estado);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Ops! Algo deu errado... :(',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.estado == null ? 'Cadastro de Estado' : 'Edição de Estado'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Salvar',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _enviar,
          ),
        ],
      ),
      body: _conteudo(),
    );
  }

  Widget _conteudo() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _formulario(),
          ),
        ),
      ),
    );
  }

  Widget _formulario() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _campos(),
      ),
    );
  }

  List<Widget> _campos() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Nome do Estado'),
        initialValue: _nomeDoEstado,
        validator: (value) => value.isNotEmpty ? null : 'Campo obrigatório',
        onSaved: (value) => _nomeDoEstado = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Unidade Federativa (UF)'),
        initialValue: _unidadeFederativa,
        validator: (value) => value.isNotEmpty ? null : 'Campo obrigatório',
        onSaved: (value) => _unidadeFederativa = value,
      ),
    ];
  }
}
