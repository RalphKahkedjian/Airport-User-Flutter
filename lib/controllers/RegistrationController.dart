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
      password: password.text
    );

    String request_body = user.toJson();
    try {
      var response = await DioClient().GetInstance().put('/auth', data: request_body);
      if (response.statusCode == 200) {
        print(response.data);
        String token = response.data['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('ACCESS_TOKEN', token);
        showsuccessdialog(context, 'Success', 'User Registered Successfully, Welcome ${name.text} ', () {
          Navigator.of(context).pushNamed('/home');
        });
      }
    } catch (err) {
      print('Error: $err');
    }
  }
}
