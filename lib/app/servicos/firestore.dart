import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ServicoDoFirestore {
  ServicoDoFirestore._();
  static final instance = ServicoDoFirestore._();

  Future<void> gravaDados({String caminho, Map<String, dynamic> dados}) async {
    final referencia = Firestore.instance.document(caminho);
    await referencia.setData(dados);
  }

  Stream<List<T>> colecaoStream<T>({
    @required String caminho,
    @required T construtor(Map<String, dynamic> dados),
  }) {
    final referencia = Firestore.instance.collection(caminho);
    final instantaneos = referencia.snapshots();
    return instantaneos.map((instantaneo) =>
        instantaneo.documents.map((instantaneo) => construtor(instantaneo.data)).toList());
  }

}