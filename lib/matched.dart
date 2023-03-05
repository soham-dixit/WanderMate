import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tourist_app/date_loc.dart' as date_loc;

class UserCard extends StatefulWidget {
  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String name = '';
  String location = '';
  String date = '';
  List areas = [];

  fetchData() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    final uid = user.uid;
    DatabaseEvent event = await databaseReference.once();
    Map<dynamic, dynamic> databaseData = event.snapshot.value as Map;

    setState(() {
      //fetch matched key from firebase
      String matchedKey = databaseData['users'][uid]['plan']['matchedKey'];
      name = databaseData['users'][matchedKey]['fullname'];
      location = databaseData['users'][uid]['plan']['location'];
      date = databaseData['users'][uid]['plan']['start_date'];
      //iterate through areas of interest
      for (var i = 0;
          i < databaseData['users'][uid]['plan']['interests'].length;
          i++) {
        areas.add(databaseData['users'][uid]['plan']['interests'][i]);
      }
      print(areas);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBF9F6),
      appBar: AppBar(
        title: const Text('Flutter Card with image and text'),
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          //<-- 1. SEE HERE
          side: const BorderSide(
            color: Color.fromARGB(255, 201, 54, 21),
            width: 3,
          ),

          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image.asset('assets/logo.png'),
              title: Text('Name: ' + name,
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Popppins')),
              subtitle: Text('Location: ' + location,
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Popppins')),
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            ),
            ListTile(
              subtitle: Text('Date: ' + date,
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Popppins')),
              contentPadding: EdgeInsets.fromLTRB(75, 0, 30, 0),
            ),
            ListTile(
              subtitle: Text('Areas of Interest: ' + areas.toString(),
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Popppins')),
              contentPadding: EdgeInsets.fromLTRB(75, 0, 30, 0),
            ),
            GFButton(
              onPressed: () {},
              text: "",
              // type: GFButtonType.transparent,
              type: GFButtonType.outline2x,
              icon: Icon(Icons.chat),
              //alignment:Alignment.bottomRight
            ),
          ],
        ),
      ),
    );
  }
}
