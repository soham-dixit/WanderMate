// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tourist_app/matched.dart';

class DateLocationDialog extends StatefulWidget {
  const DateLocationDialog({Key? key}) : super(key: key);

  @override
  _DateLocationDialogState createState() => _DateLocationDialogState();
}

class _DateLocationDialogState extends State<DateLocationDialog> {
  List<bool?> checkedValue = [false, false, false, false, false];
  List selectedValues = [];
  DateTime? _startDate;
  DateTime? _endDate;
  // remove hours from date
  String _location = '';
  String operatorName = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  String date = '';
  List interests = [];
  bool found = false;

  saveData() {
    final String newStartD = _startDate.toString().substring(0, 10);
    final String newEndD = _endDate.toString().substring(0, 10);
    final String newLocation = _location;
    final List newSelectedValues = selectedValues;
    print(newStartD);
    print(newEndD);
    print(newLocation);
    print(newSelectedValues);

    //get current user
    final databaseReference = FirebaseDatabase.instance.ref();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    final uid = user.uid;

    databaseReference.child('users').child(uid).child('plan').update({
      'start_date': newStartD,
      'end_date': newEndD,
      'location': newLocation.toLowerCase(),
      'interests': newSelectedValues,
    });
  }

  checkMate() async {
    // check if there is a match which has same dates and location and interests
    final databaseReference = FirebaseDatabase.instance.ref();
    DatabaseEvent event = await databaseReference.once();
    Map<dynamic, dynamic> databaseData = event.snapshot.value as Map;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    final uid = user.uid;
    dynamic keys_list = databaseData['users'].keys.toList();

    print(keys_list);

    for (int i = 0; i < keys_list.length; i++) {
      if (keys_list[i] != uid) {
        print(keys_list[i]);
        print(databaseData['users'][keys_list[i]]['plan']['start_date']);
        print(databaseData['users'][keys_list[i]]['plan']['end_date']);
        print(databaseData['users'][keys_list[i]]['plan']['location']);
        print(databaseData['users'][keys_list[i]]['plan']['interests']);
        print('-----------------');
        if ((databaseData['users'][keys_list[i]]['plan']['location'] ==
                    _location.toLowerCase()) &&
                (databaseData['users'][keys_list[i]]['plan']['start_date'] ==
                    _startDate.toString().substring(0, 10)) ||
            (databaseData['users'][keys_list[i]]['plan']['location'] ==
                    _location.toLowerCase()) &&
                (databaseData['users'][keys_list[i]]['plan']['end_date'] ==
                    _endDate.toString().substring(0, 10))) {
          print('found');
          found = true;
          // get key of matched user
          String matchedKey = keys_list[i];
          print(matchedKey);
          if (found == true) {
            // save matchedkey in shared preferences
            final databaseReference = FirebaseDatabase.instance.ref();
            final FirebaseAuth auth = FirebaseAuth.instance;
            final User user = auth.currentUser!;
            final uid = user.uid;

            databaseReference.child('users').child(uid).child('plan').update({
              'matchedKey': matchedKey,
            });

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserCard()));
          }
          print(found);
          break;
        }
      }
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? _startDate ?? DateTime.now()
          : _endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
        } else {
          _endDate = selectedDate;
        }
      });
    }
  }

  Widget _buildDateSelector(String title, DateTime? date, bool isStartDate) {
    final dateFormat = DateFormat('dd MMMM yyyy');
    final dateText = date != null ? dateFormat.format(date) : '';

    return InkWell(
      onTap: () => _selectDate(context, isStartDate),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(dateText),
      ),
    );
  }

  Widget _buildLocationSelector(String title) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          _location = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Dates and Location'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDateSelector('Start Date', _startDate, true),
            SizedBox(height: 16),
            _buildDateSelector('End Date', _endDate, false),
            SizedBox(height: 16),
            _buildLocationSelector('Location'),
            Container(
              child: Theme(
                data: ThemeData(unselectedWidgetColor: Color(0xFFF23F44)),
                child: CheckboxListTile(
                  title: Text(
                    'Trekking',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  value: checkedValue[0],
                  activeColor: Colors.white,
                  checkColor: Color(0xFFF23F44),
                  onChanged: (bool? value) {
                    setState(() {
                      checkedValue[0] = value!;
                    });
                    value!
                        ? selectedValues.add('Trekking')
                        : selectedValues.remove('Trekking');
                  },
                ),
              ),
            ),
            Container(
              child: Theme(
                data: ThemeData(unselectedWidgetColor: Color(0xFFF23F44)),
                child: CheckboxListTile(
                  title: Text(
                    'Museum',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  value: checkedValue[1],
                  activeColor: Colors.white,
                  checkColor: Color(0xFFF23F44),
                  onChanged: (bool? value) {
                    setState(() {
                      checkedValue[1] = value!;
                    });
                    value!
                        ? selectedValues.add('Museum')
                        : selectedValues.remove('Museum');
                  },
                ),
              ),
            ),
            Container(
              child: Theme(
                data: ThemeData(unselectedWidgetColor: Color(0xFFF23F44)),
                child: CheckboxListTile(
                  title: Text(
                    'Beach',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  value: checkedValue[2],
                  activeColor: Colors.white,
                  checkColor: Color(0xFFF23F44),
                  onChanged: (bool? value) {
                    setState(() {
                      checkedValue[2] = value!;
                    });
                    value!
                        ? selectedValues.add('Beach')
                        : selectedValues.remove('Beach');
                  },
                ),
              ),
            ),
            Container(
              child: Theme(
                data: ThemeData(unselectedWidgetColor: Color(0xFFF23F44)),
                child: CheckboxListTile(
                  title: Text(
                    'Malls',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  value: checkedValue[3],
                  activeColor: Colors.white,
                  checkColor: Color(0xFFF23F44),
                  onChanged: (bool? value) {
                    setState(() {
                      checkedValue[3] = value!;
                    });
                    value!
                        ? selectedValues.add('Malls')
                        : selectedValues.remove('Malls');
                  },
                ),
              ),
            ),
            Container(
              child: Theme(
                data: ThemeData(unselectedWidgetColor: Color(0xFFF23F44)),
                child: CheckboxListTile(
                  title: Text(
                    'Historic Monument',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  value: checkedValue[4],
                  activeColor: Colors.white,
                  checkColor: Color(0xFFF23F44),
                  onChanged: (bool? value) {
                    setState(() {
                      checkedValue[4] = value!;
                    });
                    value!
                        ? selectedValues.add('Historic')
                        : selectedValues.remove('Historic');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CANCEL'),
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(), primary: Color(0xFFF23F44)),
        ),
        ElevatedButton(
          onPressed: () {
            // Do something with selected dates and location
            // print('Selected dates: $_startDate - $_endDate');
            saveData();
            checkMate();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(), primary: Color(0xFFF23F44)),
          child: Text('OK'),
        ),
      ],
    );
  }
}
