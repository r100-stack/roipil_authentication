import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference kRoipilUsersRef =
    _firestore.collection('roipil_users');
final CollectionReference kRoipilExtendedUsersRef =
    _firestore.collection('rohan_kadkol').doc('users').collection('data');