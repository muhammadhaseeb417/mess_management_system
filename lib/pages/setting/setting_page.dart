import 'package:flutter/material.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseService = _getIt.get<DatabaseService>();
    _authService = _getIt.get<AuthService>();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final currentUser = _authService.user;
      if (currentUser == null) {
        throw Exception('No user logged in');
      }

      final fetchedUser = await _databaseService.getUser(uid: currentUser.uid);

      if (mounted) {
        setState(() {
          _user = fetchedUser;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Error fetching user data. Please try again.');
      }
      print('Error in _fetchUserData: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleLogout() async {
    try {
      setState(() => _isLoading = true);
      final result = await _authService.logout();
      if (result) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, "/login");
          _showSnackBar("Successfully logged out");
        }
      } else {
        _showSnackBar("Logout failed. Please try again.");
      }
    } catch (e) {
      _showSnackBar("An error occurred during logout");
      print('Error in _handleLogout: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getUserRollNumber() {
    if (_user == null) return 'N/A';
    final session = _user?.session ?? 'N/A';
    final department = _user?.departemnt ?? 'N/A';
    final rollNumber = _user?.rollNumber ?? 'N/A';
    return '$session-$department-$rollNumber';
  }

  Widget _buildSettingContainer(String text,
      {Color color = Colors.white, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: _isLoading ? null : onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white30,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 17,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _isLoading
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
                        Expanded(
                          child: Text(
                            "Roll Number: ${_getUserRollNumber()}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Online",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSettingContainer("Home"),
                  _buildSettingContainer("See Schedule"),
                  _buildSettingContainer("Set Meal Preference"),
                  _buildSettingContainer("Privacy & Policy"),
                  _buildSettingContainer(
                    "Log Out",
                    color: Colors.red,
                    onTap: _handleLogout,
                  ),
                ],
              ),
            ),
    );
  }
}
