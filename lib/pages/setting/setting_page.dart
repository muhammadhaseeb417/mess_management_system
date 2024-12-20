import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mess_management_system/pages/authentication/models/user_model.dart';
import 'package:mess_management_system/services/auth_service.dart';
import 'package:mess_management_system/services/database_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  UserModel? _user;
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    _authService = _getIt.get<AuthService>();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      if (_authService.user != null) {
        final fetchedUser =
            await _databaseService.getUser(uid: _authService.user!.uid);
        setState(() {
          _user = fetchedUser;
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Roll Number:   ${_user?.session ?? 'N/A'}-${_user?.departemnt ?? "N/A"}-${_user?.rollNumber ?? "N/A"}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
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
                      bool result = await _authService.logout();
                      if (result) {
                        Navigator.pushReplacementNamed(context, "/login");
                        Get.rawSnackbar(
                          icon: Icon(Icons.info),
                          message: "User Successfully Logged out",
                        );
                      }
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
