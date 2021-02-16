import 'package:firebase_auth/firebase_auth.dart' as auth;

class RoipilAuthService {
  static final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

  static Future<auth.User> signIn({String email, String password}) async {
    try {
      auth.UserCredential credential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on auth.FirebaseAuthException catch (err) {
      // throw (err); TODO: May need to throw the exception? Because _signIn can catch the exception
      print(err.message);
      return null;
    }
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
