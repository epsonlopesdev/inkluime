import 'package:app/app/autenticacao/autenticacao_button_social.dart';
import 'package:app/app/autenticacao/autenticacao_com_email_e_senha_page.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:app/custom_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AutenticacaoPage extends StatefulWidget {
  @override
  _AutenticacaoPageState createState() => _AutenticacaoPageState();
}

class _AutenticacaoPageState extends State<AutenticacaoPage> {
  bool _credencial = false;
  bool _anonimo = false;

  void _erroDeAutencicacao(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Erro na Autenticação',
      exception: exception,
    ).show(context);
  }

  Future<void> _autenticacaoAnonima(BuildContext context) async {
    try {
      setState(() => _anonimo = true);
      final autenticacao = Provider.of<AutorizacaoBase>(context);
      await autenticacao.autenticacaoAnonima();
    } on PlatformException catch (e) {
      _erroDeAutencicacao(context, e);
    } finally {
      setState(() => _anonimo = false);
    }
  }

  Future<void> _autencicacaoComContaDoGoogle(BuildContext context) async {
    try {
      setState(() => _credencial = true);
      final autenticacao = Provider.of<AutorizacaoBase>(context);
      await autenticacao.autencicacaoComContaDoGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERRO_CANCELADO_PELO_USUARIO') {
        _erroDeAutencicacao(context, e);
      }
    } finally {
      setState(() => _credencial = false);
    }
  }

  Future<void> _autencicacaoComContaDoFacebook(BuildContext context) async {
    try {
      setState(() => _credencial = true);
      final autenticacao = Provider.of<AutorizacaoBase>(context);
      await autenticacao.autencicacaoComContaDoFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERRO_CANCELADO_PELO_USUARIO') {
        _erroDeAutencicacao(context, e);
      }
    } finally {
      setState(() => _credencial = false);
    }
  }

  void _autenticacaoComEmailESenha(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => AutenticacaoComEmailESenhaPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/imagem/inkluime-logo.png',
          height: 40.0,
        ),
        elevation: 2.0,
      ),
      body: _conteudo(context),
      backgroundColor: Colors.grey[300],
    );
  }

  Widget _conteudo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildCredencialIcone(),
          SizedBox(
            height: 50.0,
          ),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/google-logo.png',
            text: 'Entrar com uma conta do Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: _credencial ? null : () => _autencicacaoComContaDoGoogle(context),
          ),
          SizedBox(
            height: 25.0,
          ),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/facebook-logo.png',
            text: 'Entrar com uma conta do Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: _credencial ? null :  () => _autencicacaoComContaDoFacebook(context),
          ),
          SizedBox(
            height: 25.0,
          ),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/email.png',
            text: 'Entrar com E-mail e Senha',
            color: Colors.blueGrey,
            textColor: Colors.white,
            onPressed: _credencial ? null :  () => _autenticacaoComEmailESenha(context),
          ),
          SizedBox(
            height: 25.0,
          ),
          Text(
            'Ou',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          _buildAnonimoIcone(),
          SizedBox(
            height: 25.0,
          ),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/spy.png',
            text: 'Entrar em modo Anonimo',
            color: Colors.black87,
            textColor: Colors.white,
            onPressed: _credencial ? null :  () => _autenticacaoAnonima(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCredencialIcone() {
    if (_credencial) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Image.asset(
      'lib/assets/imagem/badge-auth.png',
      height: 100.0,
    );
  }

    Widget _buildAnonimoIcone() {
      if (_anonimo) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Image.asset(
        'lib/assets/imagem/anonymous-icon.png',
        height: 50.0,
      );
  }
}
