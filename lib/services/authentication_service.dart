import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _user;
  Stream<FirebaseUser> get user => _userController.stream;
  bool get isLoggedin => _user != null;
  String get userEmail => _user?.email ?? "";
  final StreamController<FirebaseUser> _userController =
      StreamController<FirebaseUser>();
  AuthenticationService() {
    _firebaseAuth.onAuthStateChanged.listen((user) {
      _user = user;
      _userController.add(user);
    });
  }

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      final AuthResult authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return authResult != null;
    } catch (e) {
      return e.message;
    }
  }

  Future logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.message);
    }
  }

  Future changePassword() async {
    await _firebaseAuth.sendPasswordResetEmail(email: userEmail);
  }
}
