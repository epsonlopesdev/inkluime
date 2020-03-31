import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Usuario {
  Usuario({@required this.uid});
  final String uid;
}

abstract class AutorizacaoBase {
  Stream<Usuario> get autorizacaoAlterada;
  Future<Usuario> usuarioAtual();
  Future<Usuario> autenticacaoAnonima();
  Future<Usuario> autencicacaoComContaDoGoogle();
  Future<Usuario> autencicacaoComContaDoFacebook();
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
  Stream<Usuario> get autorizacaoAlterada {
    return _firebaseAuth.onAuthStateChanged.map(_usuarioDoFirebase);
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
  Future<Usuario> autencicacaoComContaDoGoogle() async {
    final autenticacaoComGoogle = GoogleSignIn();
    final contaDoGoogle = await autenticacaoComGoogle.signIn();
    if (contaDoGoogle != null) {
      final autorizacaoDoGoogle = await contaDoGoogle.authentication;
      if (autorizacaoDoGoogle.accessToken != null &&
          autorizacaoDoGoogle.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: autorizacaoDoGoogle.idToken,
            accessToken: autorizacaoDoGoogle.accessToken,
          ),
        );
        return _usuarioDoFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERRO_TOKEN_DO_GOOGLE_NAO_ENCONTRADO',
          message: 'Token do Google não encontrado!',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERRO_CANCELADO_PELO_USUARIO',
        message: 'Autenticação cancelada pelo usuário.',
      );
    }
  }

  @override
  Future<Usuario> autencicacaoComContaDoFacebook() async {
    final autenticacaoComFacebook = FacebookLogin();
    final result = await autenticacaoComFacebook.logIn(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        ),
      );
      return _usuarioDoFirebase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERRO_CANCELADO_PELO_USUARIO',
        message: 'Autenticação cancelada pelo usuário.',
      );
    }
  }

  @override
  Future<void> encerraSessao() async {
    final autencicacaoDoGoogle = GoogleSignIn();
    await autencicacaoDoGoogle.signOut();
    final autenticacaoDoFacebook = FacebookLogin();
    await autenticacaoDoFacebook.logOut();
    await _firebaseAuth.signOut();
  }
}
