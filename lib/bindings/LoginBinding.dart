import 'package:airportuser/controllers/LoginController.dart';
import 'package:get/get.dart';

class Loginbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> Logincontroller());
  }
}