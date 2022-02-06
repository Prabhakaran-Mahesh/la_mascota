import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:la_mascota/screens/home_screen.dart';

class FirebaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateUser(Map<String, dynamic>data, context) {
    return users
        .doc(user!.uid)
        .update(data)
        .catchError((error){
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
               content: Text('Failed to update the Location'),
           ),
         );
    });
  }

  Future<String>getAddress(lat, long)async{
    final coordinates = Coordinates(lat, long);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    return first.addressLine;
  }
}