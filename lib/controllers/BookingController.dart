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
  bookedTickets.clear();
  if (userID == null) {
    Get.snackbar("Error", "User ID not found", snackPosition: SnackPosition.BOTTOM);
    return;
  }

  try {
    var response = await DioClient().GetInstance().get('/book/$userID');
    
    if (response.statusCode == 200) {
      var ticketsData = response.data;

      if (ticketsData is List && ticketsData.isNotEmpty) {
        bookedTickets.value = ticketsData.map((ticket) {
          return {
            'id': ticket['id'],
            'ticket_id': ticket['ticket_id'],
            'quantity': ticket['quantity'],
            'status': ticket['status'],
          };
        }).toList();
      } else {
        bookedTickets.clear(); 
        Get.snackbar("No Bookings", "No tickets found for the user", snackPosition: SnackPosition.BOTTOM);
      }
    } else if (response.statusCode == 404) {
      bookedTickets.clear(); 
      Get.snackbar("Error", "No tickets found (404)", snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Failed to load tickets", snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    bookedTickets.clear();
    Get.snackbar("Error", "No booked tickets found.", snackPosition: SnackPosition.BOTTOM);
  }
}

  void deleteBooking(int bookingId, int userId) async {
    isLoading.value = true;
    try {
      var response = await DioClient().GetInstance().delete('/book/$bookingId', data: {'user_id': userId});
      
      if (response.statusCode == 200) {
        bookedTickets.removeWhere((ticket) => ticket['id'] == bookingId);
        Get.snackbar("Success", "Booking deleted successfully!", snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Failed to delete booking.", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "Could not delete booking.", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  bool isTicketBooked(int ticketId) {
    return bookedTickets.any((ticket) => ticket['id'] == ticketId);
  }
}

extension on Object {
  get response => null;
}

