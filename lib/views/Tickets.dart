import 'package:airportuser/controllers/BookingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (ticketController.bookedTickets.isEmpty) {
                return Center(
                  child: Text(
                    'No booked tickets found.',
                    style: TextStyle(color: Colors.white), 
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: ticketController.bookedTickets.length,
                  itemBuilder: (context, index) {
                    var ticket = ticketController.bookedTickets[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[900], 
                        borderRadius: BorderRadius.circular(10), 
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.airplane_ticket,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Booked Ticket ID: ${ticket['id']}',
                          style: TextStyle(color: Colors.white), 
                        ),
                        subtitle: Text(
                          'Ticket ID: ${ticket['ticket_id']}, Quantity: ${ticket['quantity']}, Status: ${ticket['status']}',
                          style: TextStyle(color: Colors.white70), 
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {

                          },
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
