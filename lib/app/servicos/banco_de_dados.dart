import 'package:app/app/administracao/estado/model/estado.dart';
import 'package:app/app/servicos/api.dart';
import 'package:flutter/foundation.dart';
import 'firestore.dart';

abstract class BancoDeDados {
  Future<void> salvaEstado(Estado estado);
  Stream<List<Estado>> estadosStream();

}

String gerarEstadoId() => DateTime.now().toIso8601String();

class FirestoreDatabase implements BancoDeDados {
  FirestoreDatabase({@ required this.usuarioId}) : assert(usuarioId != null);
  final String usuarioId;

  final _servico = ServicoDoFirestore.instance;
  Future<void> salvaEstado(Estado estado) async => _servico.gravaDados(
    caminho: CaminhoDaAPI.estado(usuarioId, estado.estadoId),
    dados: estado.toMap(),
  );

  Stream<List<Estado>> estadosStream() => _servico.colecaoStream(
      caminho: CaminhoDaAPI.estados(usuarioId),
      construtor: (dados, estadoId) => Estado.fromMap(dados, estadoId),);

}