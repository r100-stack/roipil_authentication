import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roipil_authentication/blocs/roipil_auth_bloc.dart';
import 'package:roipil_authentication/constants.dart';
import 'package:roipil_authentication/constants/firebase_constants.dart';
import 'package:roipil_authentication/models/trial_user.dart';
import 'package:roipil_authentication/roipil_authentication.dart';
import 'package:roipil_authentication/screens/sign_in_screen.dart';

void main() async {
  await RoipilAuthentication.initializeApp(
    kRoipilExtendedUsersRef,
    () => TrialUser(),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RoipilAuthBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RoipilAuthentication.initialAuthUpdates(context);
  }

  @override
  Widget build(BuildContext context) {
    TrialUser? user = context.watch<RoipilAuthBloc>().user as TrialUser?;

    return MaterialApp(
      title: user?.firebaseUser?.uid ?? 'Null',
      debugShowCheckedModeBanner: false,
      theme: kRoipilTheme,
      home: SignInScreen(
        onSignIn: () {
          TrialUser? user =
              Provider.of<RoipilAuthBloc>(context, listen: false).user as TrialUser?;
          print(user?.firebaseUser?.uid ?? 'Null');
        },
      ),
    );
  }
}
