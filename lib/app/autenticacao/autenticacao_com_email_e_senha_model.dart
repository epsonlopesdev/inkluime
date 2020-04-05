import 'package:app/app/seguranca/valida_campo.dart';

enum TipoDoFormulario { autenticacao, registro }

class EmailESennhaModel with ValidaEmailESenha {
  EmailESennhaModel(
      {this.email = '',
      this.senha = '',
      this.tipoDoFormulario = TipoDoFormulario.autenticacao,
      this.carregando = false,
      this.dadosEnviados = false});

  final String email;
  final String senha;
  final TipoDoFormulario tipoDoFormulario;
  final bool carregando;
  final bool dadosEnviados;

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

  EmailESennhaModel espelho({
    String email,
    String senha,
    TipoDoFormulario tipoDoFormulario,
    bool carregando,
    bool enviado,
  }) {
    return EmailESennhaModel(
      email: email ?? this.email,
      senha: senha ?? this.senha,
      tipoDoFormulario: tipoDoFormulario ?? this.tipoDoFormulario,
      carregando: carregando ?? this.carregando,
      dadosEnviados: enviado ?? this.dadosEnviados,
    );
  }
}
