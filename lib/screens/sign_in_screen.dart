import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:roipil_authentication/constants.dart';
import 'package:roipil_authentication/services/auth_service.dart';
import 'package:roipil_authentication/widgets/custom_text_form_input.dart';

class SignInScreen extends StatelessWidget {
  static final String routeName = '/sign-in';

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
            CustomTextFormInput(
              controller: _password,
              label: 'Password',
              validate: _validatePassword,
              obscureText: true,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kRoipilPrimaryColor,
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Image(
                image: AssetImage(
                  'assets/images/roipil_authentication_logo_transparent.png',
                  package: 'roipil_authentication',
                ),
              ),
            ),
            _createForm(),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  print('SUCCESS');
                  try {
                    await AuthService.login(
                        email: _email.text, password: _password.text);
                  } catch (err) {
                    print(err);
                  }
                } else {
                  print('FAILURE');
                }
              },
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService.logout();
              },
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
