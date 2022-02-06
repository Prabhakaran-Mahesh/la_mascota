// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_mascota/screens/authentication/email_auth_screen.dart';
import 'package:la_mascota/screens/authentication/phoneauth_screen.dart';
import 'package:la_mascota/screens/authentication/reset_password_screen.dart';
import 'package:la_mascota/screens/location_screen.dart';
import 'package:la_mascota/screens/login_screen.dart';
import 'package:la_mascota/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan.shade900,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        SplashScreen.id: (context) => const SplashScreen(),
        PhoneAuthScreen.id: (context) => const PhoneAuthScreen(),
        LocationScreen.id: (context) => const LocationScreen(),
        EmailAuthScreen.id: (context) => const EmailAuthScreen(),
        PasswordResetScreen.id: (context) => const PasswordResetScreen(),
      },
    );
  }
}