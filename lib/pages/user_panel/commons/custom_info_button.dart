import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class CustomInfoButton extends StatelessWidget {
  final String btnText;
  final Color backgroundColor;

  const CustomInfoButton(
      {super.key, required this.btnText, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: backgroundColor),
        foregroundColor: TColors.white,
      ),
      child: Text(btnText),
    );
  }
}
