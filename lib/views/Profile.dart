import 'package:airportuser/controllers/ProfileController.dart';
import 'package:airportuser/core/showSucessDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  String password = "1234567"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, String?>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final userData = snapshot.data!;
          return Center(
            child: SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Image.asset(
                'images/logo.png',
                width: 220,
                height: 220,
              ),
              SizedBox(height: 35,),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(labelText: 'User ID'),
                    controller: TextEditingController(text: userData['id']),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(labelText: 'Name'),
                    controller: TextEditingController(text: userData['name']),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(labelText: 'Email'),
                    controller: TextEditingController(text: userData['email']),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    readOnly: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    controller: TextEditingController(text: password),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            controller.logout();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blueGrey[900]),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                          child: Text("Logout", style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirm Deletion"),
                                  content: Text("Are you sure you want to delete your account? This action cannot be undone."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop(); 
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        int? userID = prefs.getInt('id');

                                        if (userID != null) {
                                          controller.deleteAccount(userID);
                                        } else {
                                          showsuccessdialog(Get.context!, "Error", "User ID not found.", () {});
                                        }
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blueGrey[900]),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                          child: Text("Delete", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            )
          );
        },
      ),
    );
  }

  Future<Map<String, String?>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    int? id = prefs.getInt('id'); 
    return {
      'name': name,
      'email': email,
      'id': id?.toString(),
    };
  }
}
