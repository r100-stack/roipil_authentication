import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:roipil_authentication/models/roipil_extended_user.dart';

import 'package:roipil_authentication/models/roipil_user.dart';

class TrialUser extends RoipilExtendedUser {
  String? role;

  TrialUser();

  // factory TrialUser.fromDocumentSnapshotAndFirebaseUser(auth.User firebaseUser, DocumentSnapshot roipilSnapshot, DocumentSnapshot trialsnapshot) {
  //   TrialUser user = TrialUser();
  //   user.updateRoipilUser(firebaseUser, roipilSnapshot);
  //   user.updateTrialExtendedUser(trialsnapshot);
  //   return user;
  // }

  @override
  void updateRoipilExtendedUser(DocumentSnapshot? snapshot) {
    role = snapshot!.get('role');
  }
}

class Abc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TrialUser trialUser = TrialUser();
    auth.User? user;
    DocumentSnapshot? roipilSnapshot;
    DocumentSnapshot? extendedSnapshot;
    trialUser.updateAllFields(user, roipilSnapshot, extendedSnapshot);

    return Container(
      
    );
  }
}