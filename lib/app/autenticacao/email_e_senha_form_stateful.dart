import 'package:app/app/seguranca/valida_campo.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:app/custom_widget/custom_submit_button.dart';
import 'package:app/custom_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'autenticacao_com_email_e_senha_model.dart';

class EmailESenhaFormStateful extends StatefulWidget with ValidaEmailESenha {
  @override
  _EmailESenhaFormStatefulState createState() => _EmailESenhaFormStatefulState();
}

class _EmailESenhaFormStatefulState extends State<EmailESenhaFormStateful> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final FocusNode _emailFocado = FocusNode();
  final FocusNode _senhaFocada = FocusNode();

  String get _email => _emailController.text;
  String get _senha => _senhaController.text;
  TipoDoFormulario _tipoDoFormulario = TipoDoFormulario.autenticacao;
  bool _dadosEnviados = false;
  bool _carregando = false;

  @override
  void dispose(){
    _emailController.dispose();
    _senhaController.dispose();
    _emailFocado.dispose();
    _senhaFocada.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    setState(() {
      _dadosEnviados = true;
      _carregando = true;
    });
    try {
      final autorizacao = Provider.of<AutorizacaoBase>(context);
      if (_tipoDoFormulario == TipoDoFormulario.autenticacao) {
        await autorizacao.autenticacaoComEmailESenha(_email, _senha);
      } else {
        await autorizacao.registroComEmailESenha(_email, _senha);
      }
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Ops! Algo deu errado... :(',
        exception: e,
      ).show(context);
      //print(e.toString());
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  void _emailPreenchido() {
    final foco =
        widget.validaEmail.ehValido(_email) ? _senhaFocada : _emailFocado;
    FocusScope.of(context).requestFocus(foco);
  }

  void _alterarTipoDoFormulario() {
    setState(() {
      _dadosEnviados = false;
      _tipoDoFormulario = _tipoDoFormulario == TipoDoFormulario.autenticacao
          ? TipoDoFormulario.registro
          : TipoDoFormulario.autenticacao;
    });
    _emailController.clear();
    _senhaController.clear();
  }

  List<Widget> _buildChildren() {
    final textoParaEntrar = _tipoDoFormulario == TipoDoFormulario.autenticacao
        ? 'Entrar'
        : 'Criar uma conta';
    final textoParaRegistrar =
        _tipoDoFormulario == TipoDoFormulario.autenticacao
            ? 'Não tem e-mail e senha? Vamos criar!'
            : 'Já tem uma conta? Entrar';

    bool botaoEntrarRegistrarHabilidatado =
        widget.validaEmail.ehValido(_email) &&
            widget.validaSenha.ehValido(_senha) &&
            !_carregando;

    return [
      _buildCampoEmail(),
      SizedBox(
        height: 20.0,
      ),
      _buildCampoSenha(),
      SizedBox(
        height: 20.0,
      ),
      CustomSubmitButtom(
        text: textoParaEntrar,
        onPressed: botaoEntrarRegistrarHabilidatado ? _entrar : null,
      ),
      SizedBox(
        height: 10.0,
      ),
      FlatButton(
        child: Text(textoParaRegistrar),
        onPressed: !_carregando ? _alterarTipoDoFormulario : null,
      ),
    ];
  }

  TextField _buildCampoEmail() {
    bool exibeMensagemDeErro =
        _dadosEnviados && !widget.validaEmail.ehValido(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocado,
      decoration: InputDecoration(
        labelText: 'E-mail',
        hintText: 'email@dominio.com',
        errorText: exibeMensagemDeErro ? widget.erroTratadoEmail : null,
        enabled: _carregando == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _atualizaState(),
      onEditingComplete: _emailPreenchido,
    );
  }

  TextField _buildCampoSenha() {
    bool exibeMensagemDeErro =
        _dadosEnviados && !widget.validaSenha.ehValido(_senha);
    return TextField(
      controller: _senhaController,
      focusNode: _senhaFocada,
      decoration: InputDecoration(
        labelText: 'Senha',
        errorText: exibeMensagemDeErro ? widget.erroTratatoSenha : null,
        enabled: _carregando == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (senha) => _atualizaState(),
      onEditingComplete: _entrar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  void _atualizaState() {
    setState(() {});
  }
}
