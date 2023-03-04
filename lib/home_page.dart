// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tourist_app/authentication/auth_service.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  String userEmail = '';

  enterData() {
    //fetch data from firebase
    final databaseReference = FirebaseDatabase.instance.ref();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    final uid = user.uid;
    // get username and email from google account
    setState(() {
      userName = user.displayName!;
      userEmail = user.email!;
    });

    // enter data to firebase
    databaseReference.child('users').child(uid).set({
      'fullname': userName,
      'email': userEmail,
    });
  }

  @override
  void initState() {
    super.initState();
    enterData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WanderMate'),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'),
              backgroundColor: Colors.white,
            ),
          ),
        ],
        backgroundColor: Color(0xFFF23F44),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Image(image: AssetImage('assets/home_pic.png')),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text('Know your location and looking for WanderMate!',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Padding(
            // add button
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all(Color(0xFFF23F44)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text('Search based on Date and Location',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text('Explore places with WanderMate based on Interest!',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Padding(
            // add button
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all(Color(0xFFF23F44)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text('Suggest based on Interest',
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFF23F44),
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color(0xFFF23F44)),
                accountName: Text(
                  "Welcome to WanderMate!",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text(""),
                currentAccountPictureSize: Size.square(50),
                // currentAccountPicture: CircleAvatar(
                //   backgroundColor: Color.fromARGB(255, 165, 255, 137),
                //   child: Text(
                //     "",
                //     style: TextStyle(fontSize: 30.0, color: Colors.blue),
                //   ), //Text
                // ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.handshake_outlined),
              title: const Text('Search Mate'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat_outlined),
              title: const Text('Chat with Mate'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Add a Trip'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                AuthService().signOut();
              },
            ),
          ],
        ),
      ), //Drawer
    );
  }
}
