import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final bool obsureText;
  final Function(String?)? onSaved;
  final RegExp? validateRegExp;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obsureText = false,
    this.onSaved,
    this.validateRegExp,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obsureText; // Initialize with the passed value
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      validator: (value) {
        if (widget.validateRegExp != null &&
            value != null &&
            widget.validateRegExp!.hasMatch(value)) {
          return null;
        } else {
          return "Please enter a valid ${widget.hintText}";
        }
      },
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obsureText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null, // No icon when obsureText is false
        hintText: widget.hintText,
      ),
    );
  }
}
