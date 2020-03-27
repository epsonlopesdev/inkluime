import 'package:app/app/autenticacao/autenticacao_button_social.dart';
import 'package:app/custom_widget/custom_raised_button.dart';
import 'package:flutter/material.dart';

import 'autenticacao_button.dart';

class AutenticacaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inklui.me'),
        elevation: 2.0,
      ),
      body: _conteudo(),
      backgroundColor: Colors.grey[300],
    );
  }

  Widget _conteudo() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Entrar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 50.0,),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/google-logo.png',
            text: 'Entrar com uma conta do Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: () {},
          ),
          SizedBox(height: 25.0,),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/facebook-logo.png',
            text: 'Entrar com uma conta do Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 25.0,),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/email.png',
            text: 'Entrar com E-mail e Senha',
            color: Colors.blueGrey,
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 25.0,),
          Text(
            'Ou',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 25.0,),
          AutenticacaoButtonSocial(
            icone: 'lib/assets/imagem/spy.png',
            text: 'Entrar em modo Anonimo',
            color: Colors.black87,
            textColor: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
