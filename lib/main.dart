import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roipil_authentication/constants.dart';
import 'package:roipil_authentication/roipil_authentication.dart';
import 'package:roipil_authentication/screens/sign_in_screen.dart';
import 'package:roipil_authentication/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await RoipilAuthentication.initialize((auth.User user) => null);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    AuthService.user.listen((auth.User user) {
      if (user != null) {
        print('Signed in as ${user.email}');
      } else {
        print('No user');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: kRoipilTheme,
      home: SignInScreen(),
    );
  }
}
