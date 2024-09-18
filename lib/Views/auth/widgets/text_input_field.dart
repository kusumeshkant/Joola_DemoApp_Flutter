import 'package:flutter/material.dart';

class TextinputField extends StatelessWidget {
  const TextinputField({
    super.key,
    this.controller,
    this.validator,
    this.labelText,
    this.obscureText = false,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
