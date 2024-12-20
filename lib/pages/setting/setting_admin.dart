import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management_system/pages/authentication/models/user_model.dart';
import 'package:mess_management_system/services/auth_service.dart';
import 'package:mess_management_system/services/database_service.dart';

class SettingAdminPage extends StatefulWidget {
  const SettingAdminPage({super.key});

  @override
  State<SettingAdminPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingAdminPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "Online",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            SettingContainor(
              Colors.white,
              "Home",
            ),
            SettingContainor(
              Colors.white,
              "See Schedule",
            ),
            SettingContainor(
              Colors.white,
              "Set Meal Preference",
            ),
            SettingContainor(
              Colors.white,
              "Privacy & Policy",
            ),
            SettingContainor(
              Colors.red,
              "Log Out",
              onTap: () async {
                Navigator.pushReplacementNamed(context, "/login");
                Get.rawSnackbar(
                  icon: Icon(Icons.info),
                  message: "Admin Successfully Logged out",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget SettingContainor(color, text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap, // Directly pass the callback here
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 17, color: color),
            ),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white30,
            width: 1,
          ),
        ),
      ),
    );
  }
}
