import 'package:airportuser/bindings/RegistrationBinding.dart';
import 'package:airportuser/routes/AppRoute.dart';
import 'package:airportuser/views/Home.dart';
import 'package:airportuser/views/Login.dart';
import 'package:airportuser/views/Registration.dart';
import 'package:get/get.dart';

class Apppage {
  static final List<GetPage> Pages = [
    GetPage(name: Approute.register, page: ()=> Registration(), binding: Registrationbinding()),
    GetPage(name: Approute.login, page: ()=>Login()),
    GetPage(name: Approute.home, page: ()=>Home())
  ];
}