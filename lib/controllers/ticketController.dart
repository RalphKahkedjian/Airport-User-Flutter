import 'package:airportuser/core/network/dioClient.dart';
import 'package:get/get.dart';

class TicketController extends GetxController {
  var tickets = <dynamic>[].obs; // Observable list for tickets

  void viewTickets() async {
    try {
      var response = await DioClient().GetInstance().get('/ticket');
      if (response.statusCode == 200) {
        var ticketData = response.data['data'];

        if (ticketData is List) {
          tickets.value = ticketData; // Set the tickets if fetched successfully
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
