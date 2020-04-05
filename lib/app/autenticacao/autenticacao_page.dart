import 'package:app/app/autenticacao/autenticacao_bloc.dart';
import 'package:app/app/autenticacao/autenticacao_button_social.dart';
import 'package:app/app/autenticacao/autenticacao_com_email_e_senha_page.dart';
import 'package:app/app/servicos/autorizacao.dart';
import 'package:app/custom_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AutenticacaoPage extends StatelessWidget {
  const AutenticacaoPage({Key key, @required this.bloc}) : super (key: key);
  final AutenticacaoBloc bloc;

  static Widget create(BuildContext context) {
    final autorizacao = Provider.of<AutorizacaoBase>(context);
    return Provider<AutenticacaoBloc>(
      builder: (_) => AutenticacaoBloc(autorizacao: autorizacao),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<AutenticacaoBloc>(
          builder: (context, bloc, _) => AutenticacaoPage(bloc: bloc),
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
      await bloc.autenticacaoAnonima();
    } on PlatformException catch (e) {
      _erroDeAutencicacao(context, e);
    }
  }

  Future<void> _autencicacaoComContaDoGoogle(BuildContext context) async {
    try {
      await bloc.autencicacaoComContaDoGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERRO_CANCELADO_PELO_USUARIO') {
        _erroDeAutencicacao(context, e);
      }
    }
  }

  Future<void> _autencicacaoComContaDoFacebook(BuildContext context) async {
    try {
      await bloc.autencicacaoComContaDoFacebook();
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
      body: StreamBuilder<bool>(
        stream: bloc.carregandoStream,
        initialData: false,
        builder: (context, snapshot) {
          return _conteudo(context, snapshot.data);
        }
      ),
      backgroundColor: Colors.grey[300],
    );
  }

  Widget _conteudo(BuildContext context, bool carregando) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildCredencialIcone(carregando),
          SizedBox(
            height: 50.0,
          ),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/google-logo.png',
            text: 'Entrar com uma conta do Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: carregando ? null : () => _autencicacaoComContaDoGoogle(context),
          ),
          SizedBox(
            height: 25.0,
          ),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/facebook-logo.png',
            text: 'Entrar com uma conta do Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: carregando ? null :  () => _autencicacaoComContaDoFacebook(context),
          ),
          SizedBox(
            height: 25.0,
          ),
          AutenticacaoButtonSocial(
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
          AutenticacaoButtonSocial(
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

  Widget _buildCredencialIcone(bool carregando) {
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
