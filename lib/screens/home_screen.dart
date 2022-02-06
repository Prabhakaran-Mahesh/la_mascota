import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:la_mascota/screens/login_screen.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: InkWell(
          onTap: (){},
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.location_solid, color: Colors.red,),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    child: Text(
                      address,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      color: Colors.grey,
                    ),
                ],
              ),
            ),
          ),
        ),
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
