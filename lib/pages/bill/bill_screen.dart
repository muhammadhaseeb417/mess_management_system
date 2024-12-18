import 'package:flutter/material.dart';

class BillScreen extends StatelessWidget {
  const BillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill'),
        centerTitle: true,
      ),
    );
  }
}
