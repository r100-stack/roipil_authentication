import 'package:flutter/material.dart';

class CustomTextFormInput extends StatelessWidget {
  final String label;
  final Function(String value) validate;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextFormInput({
    this.label,
    this.validate,
    this.keyboardType,
    this.obscureText = false,
  });

  InputBorder _buildInputBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
        width: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: Theme.of(context).accentColor,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        focusColor: Theme.of(context).accentColor,
        fillColor: Theme.of(context).accentColor,
        hoverColor: Theme.of(context).accentColor,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: _buildInputBorder(context),
        focusedBorder: _buildInputBorder(context),
        labelText: label,
      ),
      validator: validate,
    );
  }
}
