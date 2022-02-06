import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:la_mascota/screens/location_screen.dart';
import 'package:la_mascota/screens/login_screen.dart';
import 'package:la_mascota/widgets/custom_appBar.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {

  static const String id = 'HomeScreen';
  final LocationData? locationData;
  const HomeScreen({Key? key, required this.locationData}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'India';
  Future<void> getAddress() async{
    final coordinates = Coordinates(widget.locationData!.latitude!, widget.locationData!.longitude! );
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    //print("${first.featureName} : ${first.addressLine}");
    setState(() {
      //address = first.locality + ", " + first.adminArea;
      address = first.addressLine;
    });
  }

  @override
  void initState() {
    getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
          child: CustomAppbar(),
      ),
      body: Center(
        child:  ElevatedButton(
          onPressed: (){
            FirebaseAuth.instance.signOut()
            .then((value) => {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false)
            });
          },
          child: const Text(
            'Sign Out',
          ),
        ),
      ),
    );
  }
}
