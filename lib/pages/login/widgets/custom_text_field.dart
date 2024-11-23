import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final Icon? surfixIcon;
  final bool obsureText;
  final Function(String?)? onSaved;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.surfixIcon,
    this.obsureText = false,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      obscureText: obsureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: surfixIcon,
        hintText: hintText,
      ),
    );
  }
}
