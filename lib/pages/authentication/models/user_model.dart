import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? uid;
  String first_name;
  String last_name;
  String email;
  String session;
  String departemnt;
  String rollNumber;
  List<Map<String, dynamic>>? mealAttendance = []; // To track meal attendance

  UserModel({
    this.uid,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.session,
    required this.departemnt,
    required this.rollNumber,
    this.mealAttendance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'session': session,
      'departemnt': departemnt,
      'rollNumber': rollNumber,
      'mealAttendance': mealAttendance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      email: map['email'] as String,
      session: map['session'] as String,
      departemnt: map['departemnt'] as String,
      rollNumber: map['rollNumber'] as String,
      mealAttendance: map['mealAttendance'] != null
          ? List<Map<String, dynamic>>.from(
              (map['mealAttendance'] as List<dynamic>).map(
                (x) => x as Map<String, dynamic>,
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
