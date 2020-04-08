import 'package:app/app/seguranca/valida_campo.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:flutter/foundation.dart';
import 'model.dart';

class EmailESennhaNotifierModel with ValidaEmailESenha, ChangeNotifier {
  EmailESennhaNotifierModel(
      {@required this.autorizacao,
      this.email = '',
      this.senha = '',
      this.tipoDoFormulario = TipoDoFormulario.autenticacao,
      this.carregando = false,
      this.dadosEnviados = false});

  final AutorizacaoBase autorizacao;

  Future<void> entrar() async {
    atualizar(dadosEnviados: true, carregando: true);
    try {
      if (tipoDoFormulario == TipoDoFormulario.autenticacao) {
        await autorizacao.autenticacaoComEmailESenha(email, senha);
      } else {
        await autorizacao.registroComEmailESenha(email, senha);
      }
    } catch (e) {
      atualizar(carregando: false);
      rethrow;
    }
  }

  String email;
  String senha;
  TipoDoFormulario tipoDoFormulario;
  bool carregando;
  bool dadosEnviados;

  String get paraEntrar {
    return tipoDoFormulario == TipoDoFormulario.autenticacao
        ? 'Entrar'
        : 'Criar uma conta';
  }

  String get paraRegistrar {
    return tipoDoFormulario == TipoDoFormulario.autenticacao
        ? 'Não tem e-mail e senha? Vamos criar!'
        : 'Já tem uma conta? Entrar';
  }

  bool get enviarDados {
    return validaEmail.ehValido(email) &&
        validaSenha.ehValido(senha) &&
        !carregando;
  }

  String get trataCampoEmail {
    bool exibeMensagemDeErro = dadosEnviados && !validaEmail.ehValido(email);
    return exibeMensagemDeErro ? erroTratadoEmail : null;
  }

  String get trataCampoSenha {
    bool exibeMensagemDeErro = dadosEnviados && !validaSenha.ehValido(senha);
    return exibeMensagemDeErro ? erroTratatoSenha : null;
  }

  void alteraTipoDoFormulario() {
    final tipoDoFormulario =
        this.tipoDoFormulario == TipoDoFormulario.autenticacao
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
    this.email = email ?? this.email;
    this.senha = senha ?? this.senha;
    this.tipoDoFormulario = tipoDoFormulario ?? this.tipoDoFormulario;
    this.carregando = carregando ?? this.carregando;
    this.dadosEnviados = dadosEnviados ?? this.dadosEnviados;
    notifyListeners();
  }
}
