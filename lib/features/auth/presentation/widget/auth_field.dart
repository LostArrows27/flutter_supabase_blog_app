import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String placeholder;
  // get text field data
  final TextEditingController controller;
  // reveal password or not
  final bool visiblePassword;

  const AuthField(
      {super.key,
      required this.placeholder,
      required this.controller,
      this.visiblePassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: placeholder),
      controller: controller,
      // return error message
      validator: (error) {
        if (error!.isEmpty) {
          return "$placeholder is empty!";
        }

        return null;
      },
      obscureText: visiblePassword,
    );
  }
}
