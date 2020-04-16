import 'package:app/app/autenticacao/social/manager.dart';
import 'package:app/app/autenticacao/social/button.dart';
import 'package:app/app/autenticacao/email_e_senha/page.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:app/custom_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AutenticacaoPage extends StatelessWidget {
  const AutenticacaoPage({Key key, @required this.manager, @required this.carregando}) : super (key: key);
  final Manager manager;
  final bool carregando;

  static Widget create(BuildContext context) {
    final autorizacao = Provider.of<AutorizacaoBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, carregando, __) => Provider<Manager>(
          create: (_) => Manager(autorizacao: autorizacao, carregando: carregando),
          child: Consumer<Manager>(
            builder: (context, manager, _) => AutenticacaoPage(
              manager: manager,
              carregando: carregando.value,
            ),
          ),
        ),
      ),
    );
  }

  void _erroDeAutencicacao(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Erro na Autenticação',
      exception: exception,
    ).show(context);
  }

  Future<void> _autenticacaoAnonima(BuildContext context) async {
    try {
      await manager.autenticacaoAnonima();
    } on PlatformException catch (e) {
      _erroDeAutencicacao(context, e);
    }
  }

  Future<void> _autencicacaoComContaDoGoogle(BuildContext context) async {
    try {
      await manager.autencicacaoComContaDoGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERRO_CANCELADO_PELO_USUARIO') {
        _erroDeAutencicacao(context, e);
      }
    }
  }

  Future<void> _autencicacaoComContaDoFacebook(BuildContext context) async {
    try {
      await manager.autencicacaoComContaDoFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERRO_CANCELADO_PELO_USUARIO') {
        _erroDeAutencicacao(context, e);
      }
    }
  }

  void _autenticacaoComEmailESenha(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => ComEmailESenhaPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/imagem/akolhe-logo.png',
          height: 40.0,
        ),
        elevation: 2.0,
      ),
      body:  _conteudo(context),
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
          ButtonSocial(
            icone: 'lib/assets/imagem/google-logo.png',
            text: 'Entrar com uma conta do Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: carregando ? null : () => _autencicacaoComContaDoGoogle(context),
          ),
          SizedBox(
            height: 25.0,
          ),
          ButtonSocial(
            icone: 'lib/assets/imagem/facebook-logo.png',
            text: 'Entrar com uma conta do Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: carregando ? null :  () => _autencicacaoComContaDoFacebook(context),
          ),
          SizedBox(
            height: 25.0,
          ),
          ButtonSocial(
            icone: 'lib/assets/imagem/email.png',
            text: 'Entrar com E-mail e Senha',
            color: Colors.blueGrey,
            textColor: Colors.white,
            onPressed: carregando ? null :  () => _autenticacaoComEmailESenha(context),
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
          _buildAnonimoIcone(carregando),
          SizedBox(
            height: 25.0,
          ),
          ButtonSocial(
            icone: 'lib/assets/imagem/spy.png',
            text: 'Entrar em modo Anonimo',
            color: Colors.black87,
            textColor: Colors.white,
            onPressed: carregando ? null :  () => _autenticacaoAnonima(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCredencialIcone() {
    if (carregando) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Image.asset(
      'lib/assets/imagem/badge-auth.png',
      height: 100.0,
    );
  }

    Widget _buildAnonimoIcone(bool carregando) {
      if (carregando) {
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
