import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_mascota/widgets/auth_ui.dart';

import 'location_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'LoginScreen';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.cyan.shade900,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100.0,
                  ),
                  Image.asset("assets/bg.jpg",),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: AuthUi(),
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'If you continue, you are accepting\nTerms and conditions and Privacy Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
