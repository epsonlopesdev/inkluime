import 'package:flutter/foundation.dart';

class Estado {
  Estado(
      {@required this.estadoId,
      @required this.nomeDoEstado,
      @required this.unidadeFedarativa,
      @required this.estadoAtivo});

  final String estadoId;
  final String nomeDoEstado;
  final String unidadeFedarativa;
  final bool estadoAtivo;

  factory Estado.fromMap(Map<String, dynamic> dados, String estadoId) {
    if (dados == null) {
      return null;
    }

    final String nomeDoEstado = dados['nomeDoEstado'];
    final String unidadeFedarativa = dados['unidadeFedarativa'];
    final bool estadoAtivo = dados['estadoAtivo'];
    return Estado(
      estadoId: estadoId,
      nomeDoEstado: nomeDoEstado,
      unidadeFedarativa: unidadeFedarativa,
      estadoAtivo: estadoAtivo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nomeDoEstado': nomeDoEstado,
      'unidadeFedarativa': unidadeFedarativa,
      'estadoAtivo': estadoAtivo,
    };
  }
}
