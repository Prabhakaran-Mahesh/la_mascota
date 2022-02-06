
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/authentication/otp_screen.dart';
import 'package:la_mascota/screens/location_screen.dart';

class PhoneAuthService {

  FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> addUser(context) async{

    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final QuerySnapshot result = await users.where('uid', isEqualTo: user?.uid).get();

    List <DocumentSnapshot> document  = result.docs;

    if(document.length>0){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LocationScreen()),
              (route) => false
      );
    }
    else{
      return users.doc(user?.uid)
          .set({
        'uid': user?.uid,
        'mobile': user?.phoneNumber,
        'email': user?.email
      })
          .then((value){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LocationScreen()),
                (route) => false
        );
      })
          .catchError((error) => print("error"));
    }
  }

  Future<void>verifyPhoneNumber(BuildContext context, number) async{
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) async{
      if(e.code == 'invalid-phone-number'){
        // ignore: avoid_print
        print('The provided phone number is not valid.');
      }
      // ignore: avoid_print
      print(e.code);
    };



  try{
    auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OTPScreen(number: number, verId: verificationId,)));
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verification){
          print(verification);
        }
    );
  }
  catch(e){
    print(e.toString());
  }

  }
}