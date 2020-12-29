import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roipil_authentication/blocs/auth_bloc.dart';
import 'package:roipil_authentication/services/auth_service.dart';

class RoipilAuthentication {
  static void initialize(Function(auth.User) onAuthChanged) async {
    AuthBloc.changeOnAuthChanged(onAuthChanged);
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    AuthService.user.listen(onAuthChanged);
  }
}
