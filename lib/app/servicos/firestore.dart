import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ServicoDoFirestore {
  ServicoDoFirestore._();

  static final instance = ServicoDoFirestore._();

  Future<void> gravaDados(
      {@required String caminho, @required Map<String, dynamic> dados}) async {
    final referencia = Firestore.instance.document(caminho);
    await referencia.setData(dados);
  }

  Future<void> apagaDados(
      {@required String caminho}) async {
    final referencia = Firestore.instance.document(caminho);
    await referencia.delete();
  }

  Stream<List<T>> colecaoStream<T>({
    @required String caminho, @required T construtor(Map<String, dynamic> dados, String estadoId),
  }) {
    final referencia = Firestore.instance.collection(caminho);
    final instantaneos = referencia.snapshots();
    return instantaneos.map((instantaneo) => instantaneo.documents
        .map((instantaneo) =>
            construtor(instantaneo.data, instantaneo.documentID))
        .toList());
  }
}
