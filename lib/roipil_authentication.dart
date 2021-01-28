import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roipil_authentication/blocs/auth_bloc.dart';
import 'package:roipil_authentication/blocs/roipil_auth_bloc.dart';
import 'package:roipil_authentication/models/roipil_extended_user.dart';
import 'package:roipil_authentication/services/roipil_auth_service.dart';

class RoipilAuthentication {
  static CollectionReference _roipilUsersRef;
  static CollectionReference _roipilExtendedUsersRef;

  /// Call #1: Before runApp() is called in main(). Before [setupAuthRefs]() and [initialAuthUpdates]()
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  /// Call #2: After [initializeApp]() but before runApp() and [initialAuthUpdates]()
  static void setupAuthRefs(
    CollectionReference roipilUsersRef,
    CollectionReference roipilExtendedUsersRef,
  ) {
    _roipilUsersRef = roipilUsersRef;
    _roipilExtendedUsersRef = roipilExtendedUsersRef;
  }

  /// Call #3: After [initializeApp]() and [setupAuthRefs]
  static Future<void> initialAuthUpdates(
    BuildContext context,
    RoipilExtendedUser Function() newRoipilExtendedUser,
  ) async {
    auth.User firebaseUser = await RoipilAuthService.getCachedLogin();
    if (firebaseUser != null) {
      await _createRoipilExtendedUserAndUpdateProvider(
          newRoipilExtendedUser, firebaseUser, context);
    }

    RoipilAuthService.user.listen((auth.User user) async {
      if (user == null) {
        Provider.of<RoipilAuthBloc>(context, listen: false).updateUser(null);
      } else {
        await _createRoipilExtendedUserAndUpdateProvider(
            newRoipilExtendedUser, user, context);
      }
    });
    return null;
  }

  static Future _createRoipilExtendedUserAndUpdateProvider(
    RoipilExtendedUser newRoipilExtendedUser(),
    auth.User user,
    BuildContext context,
  ) async {
    RoipilExtendedUser extendedUser = newRoipilExtendedUser();
    DocumentSnapshot roipilSnapshot;
    DocumentSnapshot extendedSnapshot;

    if (!user.isAnonymous) {
      roipilSnapshot = await _roipilUsersRef.doc(user.uid).get();
      extendedSnapshot = await _roipilExtendedUsersRef.doc(user.uid).get();
    }

    extendedUser.updateAllFields(user, roipilSnapshot, extendedSnapshot);

    Provider.of<RoipilAuthBloc>(context, listen: false)
        .updateUser(extendedUser);
  }
}
