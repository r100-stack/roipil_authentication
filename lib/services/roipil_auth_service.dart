import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class RoipilAuthService {
  static final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Stream<auth.User> get user => _auth.authStateChanges();

  static Future<auth.User> login({String email, String password}) async {
    try {
      logout(); // TODO: Is this needed? Because what if tries to sign into another account without signing out, and say the second sign in failed. Then will also lose the first sign in. Then the user has to sign into the first one again. Included it here because sometimes, Provider state lost on Flutter Web. Hence, user is logged in, but shows as logged out. On re-signing in, onAuthState is not called. Hence, without logging out, user can never log back in again!

      auth.UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on auth.FirebaseAuthException catch (err) {
      // throw (err); TODO: May need to throw the exception? Because _signIn can catch the exception
      print(err.message);
      return null;
    }
  }

  static Future<auth.User> loginAnonymously() async {
    try {
      auth.UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } on auth.FirebaseAuthException catch (err) {
      // throw (err); TODO: May need to throw the exception? Because _signIn can catch the exception
      print(err.message);
      return null;
    }
  }

  static Future<void> logout() async {
    await Future.wait([_auth.signOut()]);
  }
}
