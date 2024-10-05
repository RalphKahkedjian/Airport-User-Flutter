import 'package:airportuser/bindings/LoginBinding.dart';
import 'package:airportuser/bindings/RegistrationBinding.dart';
import 'package:airportuser/routes/AppRoute.dart';
import 'package:airportuser/views/Booking.dart';
import 'package:airportuser/views/Home.dart';
import 'package:airportuser/views/Login.dart';
import 'package:airportuser/views/Profile.dart';
import 'package:airportuser/views/Registration.dart';
import 'package:airportuser/views/Tickets.dart';
import 'package:get/get.dart';

class Apppage {
  static final List<GetPage> Pages = [
    GetPage(name: Approute.register, page: ()=> Registration(), binding: Registrationbinding()),
    GetPage(name: Approute.login, page: ()=>Login(), binding: Loginbinding()),
    GetPage(name: Approute.home, page: ()=>Home()),
    GetPage(name: Approute.booking, page:()=> Booking()),
    GetPage(name: Approute.ticket, page: ()=> Tickets()),
    GetPage(name: Approute.profile, page: ()=> Profile())
  ];
}