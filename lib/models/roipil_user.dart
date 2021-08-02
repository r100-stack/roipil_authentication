import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class RoipilUser {
  auth.User? firebaseUser;
  String? name;

  void updateRoipilUser(auth.User? user, DocumentSnapshot? snapshot) {
    firebaseUser = user;

    if (snapshot == null || snapshot.data() == null) {
      return;
    }
    
    name = snapshot.get('name');
  }
}
