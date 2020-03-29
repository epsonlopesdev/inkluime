
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Usuario {
  Usuario({@required this.uid});
  final String uid;
}

abstract class AutorizacaoBase {
  Future<Usuario> usuarioAtual();
  Future<Usuario> autenticacaoAnonima();
  Future<void> encerraSessao();
}

class Autorizacao implements AutorizacaoBase {

  final _firebaseAuth = FirebaseAuth.instance;

  Usuario _usuarioDoFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return Usuario(uid: user.uid);
  }

  @override
  Future<Usuario> usuarioAtual() async {
    final usuario = await _firebaseAuth.currentUser();
    return _usuarioDoFirebase(usuario);
  }

  @override
  Future<Usuario> autenticacaoAnonima() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _usuarioDoFirebase(authResult.user);
  }

  @override
  Future<void> encerraSessao() async {
    await _firebaseAuth.signOut();
  }

}