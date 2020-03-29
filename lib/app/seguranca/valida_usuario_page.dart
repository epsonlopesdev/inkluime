import 'package:app/app/autenticacao/autenticacao_page.dart';
import 'package:app/app/home_page.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:flutter/material.dart';

class ValidaUsuario extends StatefulWidget {
  ValidaUsuario({@required this.autenticacao});

  final AutorizacaoBase autenticacao;
  @override
  _ValidaUsuarioState createState() => _ValidaUsuarioState();
}

class _ValidaUsuarioState extends State<ValidaUsuario> {

  Usuario _usuraio;

  @override
  void initState()  {
    super.initState();
    _validaUsuario();
  }

  Future<void> _validaUsuario() async {
    Usuario usuario = await widget.autenticacao.usuarioAtual();
    _atualizaUsuario(usuario);
  }

  void _atualizaUsuario(Usuario usuario) {
    setState(() {
      _usuraio = usuario;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_usuraio == null) {
      return AutenticacaoPage(
        autenticacao: widget.autenticacao,
        iniciaSessao: _atualizaUsuario,
      );
    }
    return HomePage(
      autenticacao: widget.autenticacao,
      encerraSessao: () => _atualizaUsuario(null),
    );
  }
}