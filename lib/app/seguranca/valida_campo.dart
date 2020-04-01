abstract class ValidacaoDeCampoAlfanumerico {
  bool ehValido(String value);
}

class CampoAlfanumericoNaoEhVazio implements ValidacaoDeCampoAlfanumerico {
  @override
  bool ehValido(String value) {
    return value.isNotEmpty;
  }
}

class ValidaEmailESenha {
  final ValidacaoDeCampoAlfanumerico validaEmail = CampoAlfanumericoNaoEhVazio();
  final ValidacaoDeCampoAlfanumerico validaSenha = CampoAlfanumericoNaoEhVazio();
  final String erroTratadoEmail = 'Campo e-mail é obrigatório';
  final String erroTratatoSenha = 'Campo senha é obrigatório';
}
