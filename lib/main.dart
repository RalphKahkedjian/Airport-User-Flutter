import 'package:airportuser/controllers/BookingController.dart';
import 'package:airportuser/views/Booking.dart';
import 'package:airportuser/views/Home.dart';
import 'package:airportuser/views/Login.dart';
import 'package:airportuser/views/Profile.dart';
import 'package:airportuser/views/Registration.dart';
import 'package:airportuser/views/Tickets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String startRoute = prefs.getString('token') != null ? '/home' : '/login'; 

Get.put(BookingController());
  runApp(MyApp(startRoute: startRoute));
}

class MyApp extends StatelessWidget {
  final String startRoute;
  const MyApp({super.key, required this.startRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Airport User',
      initialRoute: startRoute,
      routes: {
        '/home': (context) => const DefaultLayout(),
        '/booking' : (context) => const DefaultLayout(),
        '/register': (context) => Registration(),
        '/login': (context) => Login(),
      },
    );
  }
}

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({super.key});

  @override
  _DefaultLayoutState createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  int _selectedIndex = 0;
  String _name = "";

  @override
  void initState() {
    super.initState();
    _loadName(); 
  }

  // Load the user's name from SharedPreferences
  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "User"; 
    });
  }

  final List<Widget> _pages = [
    Home(),
    Booking(),
    Tickets(),
    Profile()
  ];

  final List<String> _titles = [
    'Home',
    'Tickets',
    'Booking',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2.5),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueGrey[900],
        unselectedItemColor: Colors.grey[500],
      ),
    );
  }
}
