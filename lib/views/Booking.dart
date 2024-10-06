import 'package:airportuser/controllers/TicketController.dart';
import 'package:airportuser/controllers/BookingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Booking extends StatelessWidget {
  static final TicketController ticketController = Get.put(TicketController());
  static final BookingController bookingController = Get.put(BookingController());

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController ticketIdController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  Booking() {
    ticketController.viewTickets();
  }


  void showBookingDialog(BuildContext context, int ticketId) {
    ticketIdController.text = ticketId.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Book Ticket'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: userIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'User ID'),
              ),
              TextField(
                controller: ticketIdController,
                keyboardType: TextInputType.number,
                enabled: false,
                decoration: InputDecoration(labelText: 'Ticket ID (pre-filled)'),
              ),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            ElevatedButton(
              onPressed: () {
                int userId = int.parse(userIdController.text);
                int quantity = int.parse(quantityController.text);
                bookingController.bookTicket(userId, ticketId, quantity);

                Navigator.of(context).pop(); 
              },
              child: Obx(() => bookingController.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Book")),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: bookingController.isLoading.value ? Colors.grey : Colors.blueGrey[900],
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        );
      },
    );
  }

  String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tickets Available", style: TextStyle(color: Colors.blueGrey[900]!)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Obx(() {
              if (ticketController.tickets.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text("No tickets available", style: TextStyle(color: Colors.blueGrey[900]!, fontSize: 18)),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: ticketController.tickets.length,
                  itemBuilder: (context, index) {
                    var ticket = ticketController.tickets[index];
                    bool isBooked = bookingController.isTicketBooked(ticket['id']);

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.blueGrey[900]!, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.airplanemode_active, size: 40, color: Colors.blueGrey[900]!),
                            SizedBox(height: 10),
                            Text(
                              "${ticket['departure']} to ${ticket['destination']}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[900]!,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Divider(color: Colors.black),
                            SizedBox(height: 8),
                            Text("ID: ${ticket['id']}", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                            SizedBox(height: 4),
                            Text("Flight: ${ticket['flight_number']}", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                            SizedBox(height: 4),
                            Text("Seat: ${ticket['seat_number']}", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                            SizedBox(height: 4),
                            Text(
                              "Departure: ${formatTime(ticket['departure_time'])}",
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Arrival: ${formatTime(ticket['arrival_time'])}",
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Spots: ${ticket['spots']}",
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: isBooked
                                  ? null 
                                  : () {
                                      showBookingDialog(context, ticket['id']);
                                    },
                                child: Text("Book"),
                                style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: isBooked ? Colors.grey : Colors.blueGrey[900],
                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
