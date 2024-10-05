import 'package:airportuser/core/network/dioClient.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketController extends GetxController {
  var tickets = <dynamic>[].obs;       
  var bookedTickets = <dynamic>[].obs; 

  void viewTickets() async {
    try {
      var response = await DioClient().GetInstance().get('/ticket');
      if (response.statusCode == 200) {
        var ticketData = response.data['data'];

        if (ticketData is List) {
          tickets.value = ticketData;
        } else {
          print("Expected ticket data to be a list but got: ${ticketData.runtimeType}");
        }
      } else {
        print("Failed to load tickets: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching tickets: $e");
    }
  }

}
