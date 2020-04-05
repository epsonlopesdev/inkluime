import 'dart:async';
import 'package:app/app/autenticacao/autenticacao_com_email_e_senha_model.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:flutter/foundation.dart';

class AutenticacaoComEmailESenhaBloc {
  AutenticacaoComEmailESenhaBloc({@required this.autorizacao});
  final StreamController<EmailESennhaModel> _modelController =
      StreamController<EmailESennhaModel>();

  final AutorizacaoBase autorizacao;

  Stream<EmailESennhaModel> get modelStream => _modelController.stream;
  EmailESennhaModel _model = EmailESennhaModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> entrar() async {
    atualizar(dadosEnviados: true, carregando: true);
    try {
      if (_model.tipoDoFormulario == TipoDoFormulario.autenticacao) {
        await autorizacao.autenticacaoComEmailESenha(
            _model.email, _model.senha);
      } else {
        await autorizacao.registroComEmailESenha(_model.email, _model.senha);
      }
    } catch (e) {
      atualizar(carregando: false);
      rethrow;
    }
  }

  void alteraTipoDoFormulario() {
    final tipoDoFormulario =
        _model.tipoDoFormulario == TipoDoFormulario.autenticacao
            ? TipoDoFormulario.registro
            : TipoDoFormulario.autenticacao;

    atualizar(
      email: '',
      senha: '',
      tipoDoFormulario: tipoDoFormulario,
      carregando: false,
      dadosEnviados: false,
    );
  }

  void autalizaEmail(String email) => atualizar(email: email);

  void autalizaSenha(String senha) => atualizar(senha: senha);

  void atualizar({
    String email,
    String senha,
    TipoDoFormulario tipoDoFormulario,
    bool carregando,
    bool dadosEnviados,
  }) {
    _model = _model.espelho(
      email: email,
      senha: senha,
      tipoDoFormulario: tipoDoFormulario,
      carregando: carregando,
      enviado: dadosEnviados,
    );
    _modelController.add(_model);
  }
}
