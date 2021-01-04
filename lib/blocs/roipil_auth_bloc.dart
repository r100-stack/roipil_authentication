import 'package:flutter/cupertino.dart';
import 'package:roipil_authentication/models/roipil_extended_user.dart';

class RoipilAuthBloc extends ChangeNotifier {
  RoipilExtendedUser _user;

  RoipilExtendedUser get user => _user;

  void updateUser(RoipilExtendedUser user) {
    _user = user;
    notifyListeners();
  }
}