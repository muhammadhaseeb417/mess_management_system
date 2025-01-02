import 'package:flutter/material.dart';
import 'package:mess_management_system/pages/Full%20Schedule/full_schedule.dart';

import '../user_panel/commons/custom_info_button.dart';
import '../view students/view_students.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.grey, // Color of the left divider
                        thickness: 1, // Thickness of the divider
                        endIndent: 10, // Spacing between divider and text
                      ),
                    ),
                    Text(
                      "Information",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.grey, // Color of the right divider
                        thickness: 1,
                        indent: 10, // Spacing between text and divider
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Add spacing below the header
                _infobuttons(context), // Move _infobuttons() outside Row
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infobuttons(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomInfoButton(
                btnText: "See Meals Schedule",
                backgroundColor: Colors.green,
                pageCallback: () =>
                    const FullSchedule(), // Ensure this is a constant
              ),
            ),
            const SizedBox(width: 10), // Add spacing between buttons
            Expanded(
              child: CustomInfoButton(
                btnText: "View Students",
                backgroundColor: const Color.fromARGB(255, 164, 148, 11),
                pageCallback: () =>
                    const ViewStudents(), // Ensure this is a constant
              ),
            ),
          ],
        ),
      ],
    );
  }
}
