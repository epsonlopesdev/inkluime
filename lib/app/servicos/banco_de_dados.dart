import 'package:app/app/administracao/estado/model/estado.dart';
import 'package:app/app/servicos/api.dart';
import 'package:flutter/foundation.dart';

import 'firestore.dart';

abstract class BancoDeDados {
  Future<void> cadastraEstado(Estado estado);
  Stream<List<Estado>> estadosStream();

}

class FirestoreDatabase implements BancoDeDados {
  FirestoreDatabase({@ required this.usuarioId}) : assert(usuarioId != null);
  final String usuarioId;

  final _servico = ServicoDoFirestore.instance;
  Future<void> cadastraEstado(Estado estado) async => _servico.gravaDados(
    caminho: CaminhoDaAPI.estado(usuarioId, 'estadoId2'),
    dados: estado.toMap(),
  );

  Stream<List<Estado>> estadosStream() => _servico.colecaoStream(
      caminho: CaminhoDaAPI.estados(usuarioId),
      construtor: (dados) => Estado.fromMap(dados),);

}