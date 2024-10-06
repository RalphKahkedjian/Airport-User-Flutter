import 'package:get/get.dart';
import 'package:airportuser/core/network/dioClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingController extends GetxController {

  var bookedTickets = <Map<String, dynamic>>[].obs;  
  var isLoading = false.obs; 
  void bookTicket(int userId, int ticketId, int quantity) async {
    var bookingData = {
      'user_id': userId,
      'ticket_id': ticketId,
      'quantity': quantity,
    };

    isLoading.value = true;

    try {
      var response = await DioClient().GetInstance().post('/book', data: bookingData);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Ticket booked successfully!", snackPosition: SnackPosition.BOTTOM);
        bookedTickets.add({
          'id': ticketId,
        });
      } else {
        Get.snackbar("Error", response.data['error'] ?? "Booking failed.", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "You've already booked this ticket", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

void viewBookedTickets() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userID = prefs.getInt('id'); 
  if (userID == null) {
    print("User ID not found.");
    return;
  }
  
  try {
    var response = await DioClient().GetInstance().get('/book/$userID');
    print(response.data); 

    if (response.statusCode == 200) {
      var ticketsData = response.data;

      if (ticketsData is List) {
        bookedTickets.value = ticketsData.map((ticket) {
          return {
            'id': ticket['id'],         
            'ticket_id': ticket['ticket_id'],
            'quantity': ticket['quantity'],    
            'status': ticket['status'],        
          };
        }).toList();
        
        print("Fetched ${bookedTickets.length} booked tickets");
      } else {
        print("Expected a list of tickets but got: ${ticketsData.runtimeType}");
      }
    } else {
      print("Failed to load booked tickets: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching booked tickets: $e");
  }
}

  bool isTicketBooked(int ticketId) {
    return bookedTickets.any((ticket) => ticket['id'] == ticketId);
  }
}
