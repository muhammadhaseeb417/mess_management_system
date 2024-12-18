import 'package:flutter/material.dart';

class CurrentBillScreen extends StatelessWidget {
  const CurrentBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Bill'),
        centerTitle: true,
      ),
    );
  }
}
