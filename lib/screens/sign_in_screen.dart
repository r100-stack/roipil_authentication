import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:roipil_authentication/constants.dart';
import 'package:roipil_authentication/services/auth_service.dart';
import 'package:roipil_authentication/widgets/custom_text_form_input.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class SignInScreen extends StatelessWidget {
  static final String routeName = '/sign-in';

  final Function onSignIn;

  const SignInScreen({
    this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();

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
      try {
        auth.User user = await AuthService.login(
          email: _email.text,
          password: _password.text,
        );
        if (user != null) {
          onSignIn();
        }
      } catch (err) {
        print(err);
      }
    }

    Widget _createSignInButton() {
      return Material(
        color: kRoipilAccentColor,
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          splashColor: kRoipilAccentColor,
          onTap: () async {
            if (_formKey.currentState.validate()) {
              _signIn();
            }
          },
          onLongPress: () async {
            // TODO: Remove sign out feature
            await AuthService.logout();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultMargin / 2, vertical: kDefaultMargin),
            child: Center(
              child: Text(
                'Sign In',
                style: TextStyle(color: kRoipilPrimaryColor),
              ),
            ),
          ),
        ),
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
            ),
            const SizedBox(
              height: kDefaultMargin * 2,
            ),
            _createSignInButton()
          ],
        ),
      );
    }

    return Theme(
      data: kRoipilTheme,
      child: Scaffold(
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
                        'assets/images/roipil_authentication_logo_transparent.png',
                        package: 'roipil_authentication',
                      ),
                    ),
                  ),
                  _createForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
