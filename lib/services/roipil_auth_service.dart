import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class RoipilAuthService {
  static final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  
  static Stream<auth.User> get user => _auth.authStateChanges();
  
  static Future<auth.User> login({String email, String password}) async {
    try {
      auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on auth.FirebaseAuthException catch (err) {
      // throw (err); TODO: May need to throw the exception? Because _signIn can catch the exception
      print(err.message);
      return null;
    }
  }

  static Future<void> logout() {
    Future.wait([
      _auth.signOut()
    ]);
  }
}