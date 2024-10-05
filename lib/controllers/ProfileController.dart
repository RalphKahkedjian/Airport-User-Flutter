import 'package:airportuser/core/network/dioClient.dart';
import 'package:airportuser/core/showSucessDialog.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
    Get.offAllNamed('/login'); 
  }

void deleteAccount(int userID) async {
  try {
    var response = await DioClient().GetInstance().delete('/auth/$userID');
    if (response.statusCode == 200) {
      showsuccessdialog(Get.context!, "User deleted successfully", "", () {
        Get.offNamed("/register");
      });
    } else {
      showsuccessdialog(Get.context!, "Error", "Failed to delete user.", () {});
    }
  } catch (e) {
    showsuccessdialog(Get.context!, "Error", "An unexpected error occurred: $e", () {});
  }
}
}
