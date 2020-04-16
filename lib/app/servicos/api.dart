class CaminhoDaAPI {
  static String estado(String usuarioId, String estadoId) => 'usuarios/$usuarioId/estados/$estadoId';
  static String estados(String usuarioId) => 'usuarios/$usuarioId/estados';

}