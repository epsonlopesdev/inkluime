import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:app/app/servicos/autorizacao.dart';

class AutenticacaoBloc {
  AutenticacaoBloc({@required this.autorizacao});

  final AutorizacaoBase autorizacao;
  final StreamController<bool> _carregandoController = StreamController<bool>();
  Stream get carregandoStream => _carregandoController.stream;

  void dispose() {
    _carregandoController.close();
  }

  void _setCarregando(bool carregando) => _carregandoController.add(carregando);

  Future<Usuario> _autenticacao(
      Future<Usuario> Function() tipoDeAutenticacao) async {
    try {
      _setCarregando(true);
      return await tipoDeAutenticacao();
    } catch (e) {
      rethrow;
    } finally {
      _setCarregando(false);
    }
  }

  Future<Usuario> autenticacaoAnonima() async =>
      await _autenticacao(autorizacao.autenticacaoAnonima);

  Future<Usuario> autencicacaoComContaDoGoogle() async =>
      await _autenticacao(autorizacao.autencicacaoComContaDoGoogle);

  Future<Usuario> autencicacaoComContaDoFacebook() async =>
      await _autenticacao(autorizacao.autencicacaoComContaDoFacebook);
}
