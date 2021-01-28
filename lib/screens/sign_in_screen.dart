import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:roipil_authentication/blocs/roipil_auth_bloc.dart';

import 'package:roipil_authentication/constants.dart';
import 'package:roipil_authentication/models/roipil_extended_user.dart';
import 'package:roipil_authentication/services/roipil_auth_service.dart';
import 'package:roipil_authentication/widgets/custom_text_form_input.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class SignInScreen extends StatelessWidget {
  static final String routeName = '/sign-in';

  final Function onSignIn;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  SignInScreen({
    this.onSignIn,
  });

  String _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Enter email';
    } else if (!EmailValidator.validate(email)) {
      return 'Please enter valid email';
    }
    return null;
  }

  String _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Enter password';
    }
    return null;
  }

  void _signIn() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    try {
      auth.User user = await RoipilAuthService.login(
        email: _email.text,
        password: _password.text,
      );
      if (user != null && onSignIn != null) {
        onSignIn();
      }
    } catch (err) {
      print(err);
    }
  }

  Widget _createCustomButton(
      {Function onTap, Function onLongPress, String text}) {
    // TODO: Make this a widget?
    return Material(
      color: kRoipilAccentColor,
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        splashColor: kRoipilAccentColor,
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultMargin / 2, vertical: kDefaultMargin),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: kRoipilPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createSignInButton() {
    return _createCustomButton(
      onTap: () => _signIn(),
      onLongPress: () async {
        // TODO: Remove sign out feature
        await RoipilAuthService.logout();
      },
      text: 'Sign in',
    );
  }

  Widget _createSignOutButton() {
    return _createCustomButton(
      onTap: () {
        RoipilAuthService.logout();
      },
      text: 'Sign out',
    );
  }

  Form _createForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormInput(
            controller: _email,
            label: 'Email',
            validate: _validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: kDefaultMargin,
          ),
          CustomTextFormInput(
            controller: _password,
            label: 'Password',
            validate: _validatePassword,
            obscureText: true,
            onSubmit: (String value) => _signIn(),
          ),
          const SizedBox(
            height: kDefaultMargin * 2,
          ),
          _createSignInButton(),
        ],
      ),
    );
  }

  Widget _buildSignOutView(RoipilExtendedUser user) {
    return Column(
      children: [
        Text(
          'Signed in as ${user.firebaseUser.email}',
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ),
        const SizedBox(height: kDefaultMargin),
        _createSignOutButton()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();

    // TextEditingController _email = TextEditingController();
    // TextEditingController _password = TextEditingController();

    RoipilExtendedUser user = Provider.of<RoipilAuthBloc>(context).user;
    bool isLoggedIn = user?.firebaseUser != null;

    return Theme(
      data: kRoipilTheme,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        backgroundColor: kRoipilPrimaryColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/authentication/images/roipil_authentication_logo_transparent.png',
                        package: 'roipil_base',
                      ),
                    ),
                  ),
                ]..addAll(
                    isLoggedIn ? [_buildSignOutView(user)] : [_createForm()],
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
