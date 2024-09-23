import 'dart:convert';

class User {
  final String? name;
  final String email;
  final String password;

  User({
    this.name,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'email' : email,
      'password' : password
    };
  }

  String toJson() => json.encode(toMap());
}