import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tourist_app/authentication/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  showSnackBar() {
    final snackBar = SnackBar(
      content: const Text(
        'Account not registered!',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
        ),
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  login() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    Future<void> signup(BuildContext context) async {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        // Getting users credential
        UserCredential result = await auth.signInWithCredential(authCredential);
        User? user = result.user;

        if (result != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } // if result not null we simply call the MaterialpageRoute,
        // for go to the HomePage screen
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFFBF9F6),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => IntroCarousel()));
                //       },
                //       icon: Icon(Icons.info_outline),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    // color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   "Enter your phone number, we will send you OTP to verify",
                //   style: TextStyle(
                //     fontFamily: 'Poppins',
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black38,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              //call login function
                              AuthService().signInWithGoogle();
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFF23F44)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   'Login as Guest',
                        //   style: TextStyle(
                        //     fontFamily: 'Poppins',
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.black38,
                        //   ),
                        // InkWell(
                        //   onTap: loginGuest,
                        //   child: Text(
                        //     'Login as Guest',
                        //     style: TextStyle(
                        //       fontFamily: 'Poppins',
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.bold,
                        //       color: Color(0xFFF23F44),
                        //     ),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.of(context).push(
                        //         MaterialPageRoute(
                        //             builder: ((context) => HomePage())));
                        //   },
                        //   child: Text(
                        //     'Home Page',
                        //     style: TextStyle(
                        //       fontFamily: 'Poppins',
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.bold,
                        //       color: Color(0xFFF23F44),
                        //     ),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
