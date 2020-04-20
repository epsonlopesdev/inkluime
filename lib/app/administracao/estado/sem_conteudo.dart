import 'package:flutter/material.dart';

class SemConteudo extends StatelessWidget {
  const SemConteudo(
      {Key key,
      this.titulo = 'Meio vazio por aqui...',
      this.mensagem = 'Vamos cadastrar alguma coisa!'})
      : super(key: key);

  final String titulo;
  final String mensagem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            titulo,
            style: TextStyle(fontSize: 32, color: Colors.black54),
          ),
          SizedBox(height: 25,),
          Text(
            mensagem,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
