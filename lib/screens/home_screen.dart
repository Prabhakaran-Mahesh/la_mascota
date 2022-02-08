import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:la_mascota/screens/location_screen.dart';
import 'package:la_mascota/screens/login_screen.dart';
import 'package:la_mascota/widgets/banner_widget.dart';
import 'package:la_mascota/widgets/category_widget.dart';
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
          child: SafeArea(child: CustomAppbar()),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  12.0,
                15.0,
                12.0,
                0.0
            ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40.0,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          labelText: 'Find Cats, Dogs, and many More..!',
                          labelStyle: const TextStyle(
                            fontSize: 12.0,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Icon(
                    Icons.notifications_none,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 10.0
            ),
            child: Column(
              children: const [
                BannerWidget(),
                CategoryWidget(),
              ],
            ),
          ),
        ],
      )
    );
  }
}
