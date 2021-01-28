import 'package:flutter/material.dart';
import 'package:roipil_authentication/constants.dart';

class CustomTextFormInput extends StatelessWidget {
  final String label;
  final Function(String value) validate;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String value) onChanged;
  final Function(String value) onSubmit;
  final TextEditingController controller;

  const CustomTextFormInput(
      {this.label,
      this.validate,
      this.keyboardType,
      this.obscureText = false,
      this.onChanged,
      this.onSubmit,
      this.controller});

  InputBorder _buildInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
        width: 0.5,
      ),
    );
  }

  InputBorder _buildErrorBorder(BuildContext context) {
    return _buildInputBorder(context).copyWith(
      borderSide: BorderSide(
        color: Colors.red,
        width: 1.0
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
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
        errorBorder: _buildErrorBorder(context),
        focusedErrorBorder: _buildErrorBorder(context),
        labelText: label,
      ),
      validator: validate,
    );
  }
}
