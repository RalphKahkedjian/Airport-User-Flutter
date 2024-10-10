import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airportuser/controllers/BookingController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tickets extends StatefulWidget {
  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  final BookingController ticketController = Get.put(BookingController());

  @override
  void initState() {
    super.initState();
    ticketController.viewBookedTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Booked Tickets'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (ticketController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (ticketController.bookedTickets.isEmpty) {
          return Center(
            child: Text(
              'No bookings found.',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }
        return ListView.builder(
          itemCount: ticketController.bookedTickets.length,
          itemBuilder: (context, index) {
            var ticket = ticketController.bookedTickets[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.airplane_ticket,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Booked Ticket ID: ${ticket['id']}',
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          int? userId = prefs.getInt('id');
                          if (userId != null) {
                            ticketController.deleteBooking(ticket['id'], userId);
                          } else {
                            Get.snackbar("Error", "User ID not found", snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                      ),
                    ],
                  ),
                  Divider(color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Ticket ID: ${ticket['ticket_id']}',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  Text(
                    'Quantity: ${ticket['quantity']}',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  Text(
                    'Status: ${ticket['status']}',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
