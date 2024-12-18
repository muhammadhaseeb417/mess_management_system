import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text("Home"),
            ),
          ],
        ),
      ),
    );
  }
}
