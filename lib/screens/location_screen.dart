
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/login_screen.dart';
import 'package:location/location.dart';

import 'home_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);
  static const String id = 'LocationScreenId';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  bool loading = false;


  Future<LocationData?>getLocation() async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Image.asset("assets/location.jpg"),
          const SizedBox(height: 20.0,),
          const Text(
              "Where do you want\nto Buy/Sell your Caress",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            'To enjoy all that we have to offer you\nWe need to know where to Look for them!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade200
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: Row(
              children: [
                Expanded(
                  child: loading?
                  Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan.shade200),
                  ))
                      :ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.cyan.shade200),
                    ),
                      onPressed: (){
                      setState(() {
                        loading = true;
                      });
                      getLocation().then((value){
                        if(value!=null){
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen(locationData: _locationData,)),
                                  (route) => false
                          );
                        }
                      });
                      },
                      icon: const Icon(CupertinoIcons.location_fill, color: Colors.black,),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Around me',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: (){},
              child: Text(
                'Set location Manually',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade200,
                  fontSize: 18.0,
                  decoration: TextDecoration.underline,
                ),
              ),
          )
        ],
      )
    );
  }
}
