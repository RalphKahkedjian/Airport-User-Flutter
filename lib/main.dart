import 'package:airportuser/routes/AppRoute.dart';
import 'package:airportuser/views/Home.dart';
import 'package:airportuser/views/Registration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: Approute.register, 
      getPages: [
        GetPage(name: Approute.register, page: () => Registration()),
        GetPage(name: '/home', page: () => Home()),
      ],
    );
  }
}
