import 'package:app/app/servicos/autorizacao.dart';
import 'package:flutter/material.dart';

class AutorizacaoProvider extends InheritedWidget {
  AutorizacaoProvider({@required this.autorizacao, @required this.child});
  final AutorizacaoBase autorizacao;
  final Widget child;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AutorizacaoBase of(BuildContext context) {
    AutorizacaoProvider provedor = context.inheritFromWidgetOfExactType(AutorizacaoProvider);
    return provedor.autorizacao;
  }
  
}