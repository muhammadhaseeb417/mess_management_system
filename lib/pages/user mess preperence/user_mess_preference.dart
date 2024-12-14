import 'dart:convert'; // For JSON serialization
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserMessPreference extends StatefulWidget {
  const UserMessPreference({super.key});

  @override
  State<UserMessPreference> createState() => _UserMessPreferenceState();
}

class _UserMessPreferenceState extends State<UserMessPreference> {
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  // Map to store user's preferences for each day (morning/evening)
  final Map<String, Map<String, bool>> _userPreferences = {};

  @override
  void initState() {
    super.initState();
    // Initialize preferences for each day
    for (var day in _daysOfWeek) {
      _userPreferences[day] = {'Morning': false, 'Evening': false};
    }
    _loadPreferences(); // Load saved preferences
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert map to JSON string
    final preferencesJson = jsonEncode(_userPreferences);
    await prefs.setString('userPreferences', preferencesJson);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences saved successfully!')),
    );
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final preferencesJson = prefs.getString('userPreferences');

    if (preferencesJson != null) {
      // Convert JSON string back to Map
      final loadedPreferences =
          jsonDecode(preferencesJson) as Map<String, dynamic>;
      setState(() {
        for (var day in _daysOfWeek) {
          if (loadedPreferences.containsKey(day)) {
            _userPreferences[day] =
                Map<String, bool>.from(loadedPreferences[day]);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mess Preferences'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select the days and times you want to do mess:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Generate rows for each day of the week
              Column(
                children: _daysOfWeek.map((day) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            day,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Morning'),
                                  value: _userPreferences[day]!['Morning'],
                                  onChanged: (value) {
                                    setState(() {
                                      _userPreferences[day]!['Morning'] =
                                          value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: CheckboxListTile(
                                  title: const Text('Evening'),
                                  value: _userPreferences[day]!['Evening'],
                                  onChanged: (value) {
                                    setState(() {
                                      _userPreferences[day]!['Evening'] =
                                          value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: _savePreferences,
                  child: const Text('Save Preferences'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
