import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roipil_authentication/constants.dart';
import 'package:roipil_authentication/screens/sign_in_screen.dart';
import 'package:roipil_authentication/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: kRoipilPrimaryColor,
        accentColor: Colors.black,
      ),
      home: SignInScreen(),
    );
  }
}
