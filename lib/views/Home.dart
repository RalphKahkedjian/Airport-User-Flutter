import 'package:airportuser/controllers/TicketController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static final TicketController ticketController = Get.put(TicketController());
  String? userName;

  @override
  void initState() {
    super.initState();
    ticketController.viewTickets();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, String?> userData = await _getUserData();
    setState(() {
      userName = userData['name'] ?? 'Guest';
    });
  }

  Future<Map<String, String?>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    return {
      'name': name,
    };
  }

 @override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "What's up, ",
                          style: TextStyle(
                            color: Colors.blueGrey[900],
                            fontSize: 27,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: userName ?? '',
                          style: TextStyle(
                            color: Colors.blue[900], 
                            fontSize: 27,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Container(
              width: screenWidth,
              height: 500, 
              decoration: BoxDecoration(
                color: Color.lerp(Colors.blueGrey[900], const Color.fromARGB(255, 24, 23, 27), 0.2),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "IRA Flight Stats",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Divider(color: Colors.white,),
                    SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatBox('On-Time\nFlights', '75%'),
                        _buildStatBox('Passenger\nFlights', '150k+'),
                        _buildStatBox('Countries\nFlown', '8+'),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatBox('Customer\nSatisfaction', '90%'),
                        _buildStatBox('Avg. Flight\nDuration', '3.5 hrs'),
                        _buildStatBox('Frequent\nFlyers', '20k+'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Offers", 
                    style: TextStyle(
                      color: Colors.blueGrey[900], 
                      fontWeight: FontWeight.w800, 
                      fontSize: 27, 
                      letterSpacing: 2.5
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: <Widget>[
                SizedBox(height: 2,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    _buildOfferBox(
                      "Discount\n50% Off", 
                      "Get 50% off on \n all tickets!", 
                      Colors.blueGrey[800] ?? Colors.blueGrey, 
                      'images/firstOffer.png'
                    ),
                    SizedBox(width: 10),
                    _buildOfferBox(
                      "Buy 1 Get\n1 Free", 
                      "Buy one ticket and get another free!", 
                      Colors.purple[900] ?? Colors.purple, 
                      'images/secondOffer.png'
                    ),
                    SizedBox(width: 10),
                    _buildOfferBox(
                      "Flight + Hotel\nPackage", 
                      "Book a flight and hotel together for a discount!", 
                      Colors.teal[800] ?? Colors.teal, 
                      'images/thirdOffer.png'
                    ),
                    SizedBox(width: 10),
                    _buildOfferBox(
                      "Special Rates\nfor Students", 
                      "Exclusive discounts for students with valid ID!", 
                      Colors.deepOrange[900] ?? Colors.deepOrange, 
                      'images/fourthOffer.png'
                    ),
                    SizedBox(width: 10),
                    _buildOfferBox(
                      "Weekend Deals\n20% Off", 
                      "Save 20% on weekend flights!", 
                      Colors.indigo[900] ?? Colors.indigo, 
                      'images/fifthOffer.png'
                    ),
                  ],
                ),
              )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildOfferBox(String offerText, String description, Color color, String imagePath) {
  return Container(
    width: 250, 
    height: 420, 
    decoration: BoxDecoration(
      color: color ?? Colors.grey,
      borderRadius: BorderRadius.circular(20), 
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 15),
        Text(
          offerText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 20),
        Padding(padding: const EdgeInsets.all(20),
        child:         Text(
          description,
          textAlign: TextAlign.center, 
          style: TextStyle(
            color: Colors.white70, 
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),),
        SizedBox(height: 13), 
        Container(
          width: 200,
          height: 150, 
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover, 
            ),
          ),
        ),
      ],
    ),
  );
}



  Widget _buildStatBox(String label, String stat) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center, 
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8), 
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), 
            ),
          ),
          child: Center(
            child: Text(
              stat, 
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 21,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
