import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roipil_authentication/models/roipil_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class RoipilExtendedUser extends RoipilUser {
  void updateRoipilExtendedUser(DocumentSnapshot snapshot);

  void updateAllFields(
    auth.User firebaseUser,
    DocumentSnapshot roipilSnapshot,
    DocumentSnapshot extendedSnapshot,
  ) {
    updateRoipilUser(firebaseUser, roipilSnapshot);
    updateRoipilExtendedUser(extendedSnapshot);
  }

  // void updateRoipilExtendedUser(auth.User firebaseUser, DocumentSnapshot roipilSnapshot, DocumentSnapshot trialsnapshot) {

  // }

  // factory RoipilExtendedUser.fromDocumentSnapshotAndFirebaseUser(auth.User firebaseUser, DocumentSnapshot snapshot) {
  //   RoipilExtendedUser user = RoipilExtendedUser();
  //   user.updateRoipilUser(firebaseUser, roipilSnapshot);
  //   user.updateTrialExtendedUser(trialsnapshot);
  //   return user;
  // }
}
