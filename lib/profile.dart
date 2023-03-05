// // ignore_for_file: prefer_const_constructors

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tourist_app/authentication/auth_service.dart';
// import 'package:tourist_app/date_int.dart';
// import 'package:tourist_app/date_loc.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {


//   @override



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WanderMate'),
//         // ignore: prefer_const_literals_to_create_immutables
//         actions: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
//             child: CircleAvatar(
//               backgroundImage: AssetImage('assets/logo.png'),
//               backgroundColor: Colors.white,
//             ),
//           ),
//         ],
//         backgroundColor: Color(0xFFF23F44),
//       ),
//       body: SingleChildScrollView(
//         child: operatorName == 's'
//               ? Container(
//                   padding: EdgeInsets.only(top: 300),
//                   child: Center(
//                     child: CupertinoActivityIndicator(),
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.fromLTRB(30, 40, 30, 50),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Center(
//                         child: CircleAvatar(
//                           backgroundImage: url != null
//                               ? NetworkImage(url)
//                               : AssetImage('assets/logo/profile.png')
//                                   as ImageProvider,
//                           // : AssetImage('assets/profile.png')
//                           //     as ImageProvider  ,
//                           // backgroundImage: AssetImage('assets/profile.png'),
//                           backgroundColor: Color(0xFFF23F44),
//                           radius: 80,

//                           child: Stack(
//                             children: [
//                               Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: CircleAvatar(
//                                   radius: 23,
//                                   backgroundColor: Color(0xFFF23F44),
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.edit,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () {
//                                       // takePhoto(ImageSource.gallery);
//                                     },
//                                   )
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         // child: InkWell(
//                         //   onTap: () {},
//                         // )),
//                       ),
//                       Divider(
//                         height: 60,
//                         color: Colors.grey.shade400,
//                         thickness: 1,
//                       ),
//                       Text(
//                         'NAME',
//                         style: TextStyle(
//                             color: Colors.black,
//                             letterSpacing: 2,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       AutoSizeText(
//                         operatorName,
//                         style: TextStyle(
//                             color: Color(0xFFF23F44),
//                             letterSpacing: 2,
//                             fontSize: 18),
//                         maxLines: 1,
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Text(
//                         'EMAIL ID',
//                         style: TextStyle(
//                             color: Colors.black,
//                             letterSpacing: 2,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       AutoSizeText(
//                         operatorEmail,
//                         style: TextStyle(
//                             color: Color(0xFFF23F44),
//                             letterSpacing: 2,
//                             fontSize: 18),
//                         maxLines: 1,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Divider(
//                         height: 40,
//                         color: Colors.grey[400],
//                         thickness: 1,
//                       ),
//                     ],
//                   ),
//               ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: const EdgeInsets.all(0),
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xFFF23F44),
//               ), //BoxDecoration
//               child: UserAccountsDrawerHeader(
//                 decoration: BoxDecoration(color: Color(0xFFF23F44)),
//                 accountName: Text(
//                   "Welcome to WanderMate!",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 accountEmail: Text(""),
//                 currentAccountPictureSize: Size.square(50),
//                 // currentAccountPicture: CircleAvatar(
//                 //   backgroundColor: Color.fromARGB(255, 165, 255, 137),
//                 //   child: Text(
//                 //     "",
//                 //     style: TextStyle(fontSize: 30.0, color: Colors.blue),
//                 //   ), //Text
//                 // ), //circleAvatar
//               ), //UserAccountDrawerHeader
//             ), //DrawerHeader
//             ListTile(
//               leading: const Icon(Icons.handshake_outlined),
//               title: const Text('Search Mate'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.chat_outlined),
//               title: const Text('Chat with Mate'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.calendar_month_outlined),
//               title: const Text('Add a Trip'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.account_circle_outlined),
//               title: const Text('My Profile'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: () async {
//                 AuthService().signOut();
//               },
//             ),
//           ],
//         ),
//       ), //Drawer
//     );
//   }
// }
