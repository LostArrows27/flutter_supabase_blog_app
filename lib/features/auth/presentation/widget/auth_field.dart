import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String placeholder;

  const AuthField({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: placeholder),
    );
  }
}
