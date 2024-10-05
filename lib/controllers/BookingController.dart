import 'package:get/get.dart';
import 'package:airportuser/core/network/dioClient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingController extends GetxController {
  var bookedTickets = <int>{}.obs; // Set to track booked tickets for the user
  var isLoading = false.obs; // To track loading state

  void bookTicket(int userId, int ticketId, int quantity) async {
    // Prepare booking data
    var bookingData = {
      'user_id': userId,
      'ticket_id': ticketId,
      'quantity': quantity,
    };

    isLoading.value = true;

    try {
      // Make the POST request to the API
      var response = await DioClient().GetInstance().post('/book', data: bookingData);

      if (response.statusCode == 200) {
        // Handle successful booking response
        Get.snackbar("Success", "Ticket booked successfully!", snackPosition: SnackPosition.BOTTOM);

        // Mark the ticket as booked by adding ticketId to bookedTickets
        bookedTickets.add(ticketId);
      } else {
        Get.snackbar("Error", response.data['error'] ?? "Booking failed.", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please check your internet connection.", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  bool isTicketBooked(int ticketId) {
    return bookedTickets.contains(ticketId);
  }
}
