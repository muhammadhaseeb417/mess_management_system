import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class CustomInfoButton extends StatelessWidget {
  final String btnText;
  final Color backgroundColor;
  final Widget Function() pageCallback;

  const CustomInfoButton({
    super.key,
    required this.btnText,
    required this.backgroundColor,
    required this.pageCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the page returned by the callback
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pageCallback()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: backgroundColor),
        foregroundColor: TColors.white,
      ),
      child: Text(btnText),
    );
  }
}
