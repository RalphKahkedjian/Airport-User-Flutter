import 'package:airportuser/controllers/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {

  static final Logincontroller controller = Get.put(Logincontroller());
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text("Booking", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ElevatedButton(onPressed: (){
                controller.logout(context);
              },
              child: Text("logout")),
            )
          ],
        ),
      ),
    );
  }
}
