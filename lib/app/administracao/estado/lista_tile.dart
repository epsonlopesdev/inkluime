import 'package:flutter/material.dart';
import 'model/estado.dart';

class ListaTileDeEstado extends StatelessWidget {
  final Estado estado;
  final VoidCallback aoClicar;

  const ListaTileDeEstado({Key key, @required this.estado, this.aoClicar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(estado.nomeDoEstado),
      trailing: Icon(Icons.chevron_right),
      onTap: aoClicar,
    );
  }
}
