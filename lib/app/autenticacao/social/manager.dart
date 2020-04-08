import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:app/app/servicos/autorizacao.dart';

class Manager {
  Manager({@required this.autorizacao, @required this.carregando});
  final AutorizacaoBase autorizacao;
  final ValueNotifier<bool> carregando;

  Future<Usuario> _autenticacao(
      Future<Usuario> Function() tipoDeAutenticacao) async {
    try {
      carregando.value = true;
      return await tipoDeAutenticacao();
    } catch (e) {
      rethrow;
    } finally {
      carregando.value = false;
    }
  }

  Future<Usuario> autenticacaoAnonima() async =>
      await _autenticacao(autorizacao.autenticacaoAnonima);

  Future<Usuario> autencicacaoComContaDoGoogle() async =>
      await _autenticacao(autorizacao.autencicacaoComContaDoGoogle);

  Future<Usuario> autencicacaoComContaDoFacebook() async =>
      await _autenticacao(autorizacao.autencicacaoComContaDoFacebook);
}
