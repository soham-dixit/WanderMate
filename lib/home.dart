// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:tourist_app/authentication/auth_service.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String userName = '';
//   String userEmail = '';
//   String userPhotoUrl = '';

//   getData() async {
//     final databaseReference = FirebaseDatabase.instance.ref();
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final User user = await auth.currentUser!;
//     final uid = user.uid;
//     DatabaseEvent event = await databaseReference.once();
//     Map<dynamic, dynamic> databaseData = event.snapshot.value as Map;

//     // final pref = await SharedPreferences.getInstance();
//     // final key = pref.getString('operator-key');
//     setState(() {
//       // userName = databaseData['users'][uid]['fullname'];
//       // userEmail = databaseData['users'][uid]['email'];
//       userPhotoUrl = user.photoURL!;
//       print(userPhotoUrl);
//     });
//   }

//   int _selectedIndex = 0;
//   // ignore: prefer_final_fields
//   static List<Widget> _widgetOptions = <Widget>[
//     Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//           child: Image(image: AssetImage('assets/home_pic.png')),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
//           child: Text('Know your location and looking for WanderMate!',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//         ),
//         Padding(
//           // add button
//           padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ButtonStyle(
//               foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//               backgroundColor: MaterialStateProperty.all(Color(0xFFF23F44)),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24.0),
//                 ),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//               child: Text('Search based on Date and Location',
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
//           child: Text('Explore places with WanderMate based on Interest!',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//         ),
//         Padding(
//           // add button
//           padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ButtonStyle(
//               foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//               backgroundColor: MaterialStateProperty.all(Color(0xFFF23F44)),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24.0),
//                 ),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//               child: Text('Suggest based on Interest',
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//             ),
//           ),
//         ),
//       ],
//     ),
//     Text('Chat with Mate',
//         style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
//     Text('Chat with Mate',
//         style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
//     // MaterialButton(
//     //   padding: const EdgeInsets.all(10),
//     //   color: Colors.green,
//     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//     //   child: const Text(
//     //     'LOG OUT',
//     //     style: TextStyle(color: Colors.white, fontSize: 15),
//     //   ),
//     //   onPressed: () {
//     //     AuthService().signOut();
//     //   },
//     // ),
//     Column(
//       children: [
//         // display fetched profile picture
//         Text(
//           'NAME',
//           style: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2,
//               fontFamily: 'Poppins'),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         AutoSizeText(
//           FirebaseAuth.instance.currentUser!.displayName!,
//           style: TextStyle(
//               color: Color(0xFFF23F44),
//               letterSpacing: 2,
//               fontSize: 18,
//               fontFamily: 'Poppins'),
//           maxLines: 1,
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         Text(
//           'EMAIL ID',
//           style: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2,
//               fontFamily: 'Poppins'),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             AutoSizeText(
//               FirebaseAuth.instance.currentUser!.email!,
//               style: TextStyle(
//                 color: Color(0xFFF23F44),
//                 letterSpacing: 2,
//                 fontSize: 18,
//                 fontFamily: 'Poppins',
//               ),
//               maxLines: 1,
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         MaterialButton(
//           padding: const EdgeInsets.all(10),
//           color: Color(0xFFF23F44),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//           child: const Text(
//             'LOG OUT',
//             style: TextStyle(color: Colors.white, fontSize: 15),
//           ),
//           onPressed: () {
//             AuthService().signOut();
//           },
//         ),
//       ],
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text('WanderMate'),
//           // ignore: prefer_const_literals_to_create_immutables
//           actions: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//               child: CircleAvatar(
//                 backgroundImage: AssetImage('assets/logo.png'),
//                 backgroundColor: Colors.white,
//               ),
//             ),
//           ],
//           backgroundColor: Color(0xFFF23F44)),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           selectedItemColor: Color(0xFFF23F44),
//           unselectedItemColor: Colors.black,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.handshake_outlined),
//               label: 'Search Mate',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat_outlined),
//               label: 'Chat with Mate',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_month_outlined),
//               label: 'Add a Trip',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle_outlined),
//               label: 'My Profile',
//             ),
//           ],
//           type: BottomNavigationBarType.shifting,
//           currentIndex: _selectedIndex,
//           // selectedItemColor: Colors.black,
//           iconSize: 40,
//           onTap: _onItemTapped,
//           elevation: 5),
//     );
//   }
// }
