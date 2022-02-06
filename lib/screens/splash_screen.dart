import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/location_screen.dart';
import 'package:la_mascota/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  static const String id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(
      const Duration(
        seconds: 3,
      ), () {
        FirebaseAuth.instance.authStateChanges().listen((user) {
          if(user == null){
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          }
          else{
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LocationScreen()),
                (route) => false
          );
          }
        });
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Center(child: Image.asset("assets/logo.png"),),
    );
  }
}
