import 'package:airportuser/core/network/dioClient.dart';
import 'package:airportuser/core/showSucessDialog.dart';
import 'package:airportuser/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logincontroller extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void login(BuildContext context) async {
    User user = User(
      email: email.text,
      password: password.text,
    );

    String requestBody = user.toJson();
    try {
      var response = await DioClient().GetInstance().post('/auth', data: requestBody);

      if (response.statusCode == 200) {
        String name = response.data['user']['name'];
        String userEmail = response.data['user']['email'];
        int userId = response.data['user']['id'];
        String token = response.data['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('ACCESS_TOKEN', token);
        await prefs.setString('name', name);
        await prefs.setString('email', userEmail);
        await prefs.setInt('id', userId);


        showsuccessdialog(context, "Success", "Welcome back, $name", () {
          print("Name: " + name);
          print("Token: " + token);
          Future.delayed(const Duration(seconds: 2), () {
            Get.offNamed('/home');
          });
        });
      } else {
        showsuccessdialog(Get.context!, "Failed", "Incorrect email or password", null);
      }
    } catch (err) {
      showsuccessdialog(Get.context!, "Failed", "An error occurred", null);
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("ACCESS_TOKEN");
    Get.offNamed('/login');
  }
}
