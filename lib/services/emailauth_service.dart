

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/authentication/email_verification_screen.dart';
import 'package:la_mascota/screens/location_screen.dart';

class EmailAuthentication {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<DocumentSnapshot> getAdminCredential(email, password, islog, context)async{
    DocumentSnapshot _result = await users.doc(email).get();


    if(islog) {
      emailLogin(email, password, context);
    }else{
      if(_result.exists){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Account already Exits"),
          )
        );
      }
      else{
        emailRegister(email, password, context);
      }
    }

    return _result;
  }

  emailLogin(email, password, context)async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      if(userCredential.user!.uid != null){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LocationScreen()),
                (route) => false
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No user found for that email.'),
            )
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong password provided for that user.'),
            )
        );
      }
    }
  }
  emailRegister(email, password, context)async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
      if(userCredential.user!.uid != null){
        return users.doc(userCredential.user!.email).set({
          'uid' : userCredential.user!.uid,
          'email' : userCredential.user!.email,
          'mobile' : null,
        }).then((value)async{

          await userCredential.user!.sendEmailVerification().then((value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => EmailVerificationScreen()));
          });

        }).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to add User'),
              )
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The password provided is too weak.'),
            )
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The account already exists for that email.'),
            )
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          )
      );
    }

  }
}