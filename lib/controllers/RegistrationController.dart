import 'package:airportuser/core/network/dioClient.dart';
import 'package:airportuser/core/showSucessDialog.dart';
import 'package:airportuser/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void register(BuildContext context) async {
    User user = User(
      name: name.text,
      email: email.text,
      password: password.text,
    );

    String request_body = user.toJson();
    try {
      var response = await DioClient().GetInstance().put('/auth', data: request_body);
      if (response.statusCode == 200) {
        print(response.data);

        // Extracting the response data safely
        String token = response.data['token'];
        int? id = response.data['user']?['id'];  // Using null-aware operator in case 'id' is null
        String? userEmail = response.data['user']?['email'];
        String userName = response.data['user']?['name'];

        if (id != null && userEmail != null) {
          // Storing data in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('ACCESS_TOKEN', token);
          await prefs.setInt('id', id);  // id is nullable, but ensure it's not null before storing
          await prefs.setString('email', userEmail);
          await prefs.setString('name', userName);

          // Show success dialog and navigate
          showsuccessdialog(
            context,
            'Success',
            'User Registered Successfully,\n Welcome ${name.text}',
            () {
              Navigator.of(context).pushNamed('/home');
              print([name.text, userEmail, id]);
            },
          );
        } else {
          print('Error: ID or email is null');
          showsuccessdialog(
            context,
            'Error',
            'Registration failed. Invalid user data returned.',
            () {
              Navigator.of(context).pop();
            },
          );
        }
      }
    } catch (err) {
      print('Error: $err');
    }
  }
}
