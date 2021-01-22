import 'package:after_layout/after_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roipil_authentication/blocs/roipil_auth_bloc.dart';
import 'package:roipil_authentication/constants.dart';
import 'package:roipil_authentication/constants/firebase_constants.dart';
import 'package:roipil_authentication/models/trial_user.dart';
import 'package:roipil_authentication/roipil_authentication.dart';
import 'package:roipil_authentication/screens/sign_in_screen.dart';
import 'package:roipil_authentication/services/roipil_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await RoipilAuthentication.initializeApp(
      kRoipilUsersRef, kRoipilExtendedUsersRef);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RoipilAuthBloc(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin<MyApp> {
  @override
  void initState() {
    super.initState();

    // RoipilAuthService.user.listen((auth.User user) {
    //   if (user != null) {
    //     print('Signed in as ${user.email}');
    //   } else {
    //     print('No user');
    //   }
    // });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    RoipilAuthentication.initialAuthUpdates(context, () => TrialUser());
  }

  @override
  Widget build(BuildContext context) {
    TrialUser user = context.watch<RoipilAuthBloc>().user;

    return MaterialApp(
      title: user?.firebaseUser?.uid ?? 'Null',
      debugShowCheckedModeBanner: false,
      theme: kRoipilTheme,
      home: SignInScreen(),
    );
  }
}
