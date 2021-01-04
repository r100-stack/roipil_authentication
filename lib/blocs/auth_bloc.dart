import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthBloc { // TODO: Does it need to extend ChangeNotifier (Provider implementation) or is just static enough
// TODO: May need to remove the onAuthChanged from auth_bloc to avoid confusion with auth_bloc from other projects.
  static Function(auth.User) _onAuthChanged;

  static Function(auth.User) get onAuthChanged => _onAuthChanged;

  static void changeOnAuthChanged(Function(auth.User) onAuthChanged) {
    _onAuthChanged = onAuthChanged;
    // TODO: Do we need to notify listeners?
  }
}
