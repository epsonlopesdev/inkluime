import 'package:flutter/foundation.dart';

class Estado {
  Estado({@required this.nome, @required this.uf, @ required this.ativo});

  final String nome;
  final String uf;
  final bool ativo;

  factory Estado.fromMap(Map<String, dynamic> dados) {
    if (dados == null) {
      return null;
    }
    final String nome = dados['nome'];
    final String uf = dados['uf'];
    final bool ativo = dados['ativo'];
    return Estado (
      nome: nome,
      uf: uf,
      ativo: ativo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'uf': uf,
      'ativo': ativo,
    };
  }


}