import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roipil_authentication/blocs/roipil_auth_bloc.dart';
import 'package:roipil_authentication/constants/firebase_constants.dart';
import 'package:roipil_authentication/models/roipil_extended_user.dart';
import 'package:roipil_authentication/services/roipil_auth_service.dart';

class RoipilAuthentication {
  static late CollectionReference _roipilExtendedUsersRef;
  static late RoipilExtendedUser Function() _generateNewRoipilExtendedUser;

  /// Call #1: Before runApp() is called in main() and also before [initialAuthUpdates]()
  static Future<void> initializeApp(
    CollectionReference roipilExtendedUsersRef,
    RoipilExtendedUser Function() generateRoipilExtendedUser,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    _roipilExtendedUsersRef = roipilExtendedUsersRef;
    _generateNewRoipilExtendedUser = generateRoipilExtendedUser;
  }

  /// Call #2: After [initializeApp]()
  static Future initialAuthUpdates(BuildContext context) async {
    auth.FirebaseAuth firebaseAuth = RoipilAuthService.firebaseAuth;
    Stream<auth.User?> userChanges = firebaseAuth.userChanges();

    userChanges.listen((auth.User? firebaseUser) async {
      RoipilExtendedUser? user;

      if (firebaseUser != null) {
        String uid = firebaseUser.uid;
        DocumentReference roipilDocRef = kRoipilUsersRef.doc(uid);
        DocumentReference extendedDocRef = _roipilExtendedUsersRef.doc(uid);

        DocumentSnapshot roipilSnapshot = await roipilDocRef.get();
        DocumentSnapshot extendedSnapshot = await extendedDocRef.get();

        user = _generateNewRoipilExtendedUser();
        user.updateAllFields(firebaseUser, roipilSnapshot, extendedSnapshot);
      }

      context.read<RoipilAuthBloc>().updateUser(user);
    });

    return null;
  }
}
