import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class AuthService {
  static final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  
  static Stream<auth.User> get user => _auth.authStateChanges();
  
  static Future<void> login({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on auth.FirebaseAuthException catch (err) {
      // throw (err); TODO: May need to throw the exception?
      print(err.message);
    }
  }

  static Future<void> logout() {
    Future.wait([
      _auth.signOut()
    ]);
  }
}