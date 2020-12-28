import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:roipil_authentication/constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:roipil_authentication/services/auth_service.dart';
import 'package:roipil_authentication/widgets/custom_text_form_input.dart';

class SignInScreen extends StatelessWidget {
  static final String routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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

    return Scaffold(
      backgroundColor: kRoipilPrimaryColor,
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Image(
                image: AssetImage(
                    'assets/images/roipil_authentication_logo_transparent.png'),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormInput(
                    label: 'Email',
                    validate: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextFormInput(
                    label: 'Password',
                    validate: _validatePassword,
                    obscureText: true,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  print('SUCCESS');
                  // auth.User user = await login()s
                } else {
                  print('FAILURE');
                }
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
