import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final Icon? surfixIcon;
  final bool obsureText;
  final Function(String?)? onSaved;
  final RegExp? validateRegExp;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.surfixIcon,
    this.obsureText = false,
    this.onSaved,
    this.validateRegExp,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value) {
        if (validateRegExp != null &&
            value != null &&
            validateRegExp!.hasMatch(value)) {
          return null;
        } else {
          return "Please enter a valid ${hintText}";
        }
      },
      obscureText: obsureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: surfixIcon,
        hintText: hintText,
      ),
    );
  }
}
