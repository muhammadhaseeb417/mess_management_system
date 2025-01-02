import 'package:flutter/material.dart';
import '../../services/database_service.dart';
import '../authentication/models/user_model.dart';

class ViewStudents extends StatelessWidget {
  const ViewStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Students'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: DatabaseService().getAllStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No students found.'));
          } else {
            final students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                final rollNumber =
                    "${student.session ?? 'N/A'}-${student.departemnt ?? 'N/A'}-${student.rollNumber ?? 'N/A'}";
                return ListTile(
                  tileColor: Colors.white10,
                  leading: Icon(Icons.person, size: 30),
                  title: Text("${student.first_name} ${student.last_name}" ??
                      'No Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(student.email ?? 'No Email'),
                      Text('Roll: $rollNumber'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
