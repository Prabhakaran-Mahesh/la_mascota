
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:la_mascota/screens/login_screen.dart';
import 'package:la_mascota/services/firebase_Services.dart';
import 'package:location/location.dart';

import 'home_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);
  static const String id = 'LocationScreenId';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {


  final FirebaseService _firebaseService = FirebaseService();

  Location location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String manualAddress = "";

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
    final coordinates = Coordinates(_locationData!.latitude!, _locationData!.longitude! );
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    //print("${first.featureName} : ${first.addressLine}");
    setState(() {
      //address = first.locality + ", " + first.adminArea;
      address = first.addressLine;
      countryValue = first.countryName;
    });
    return _locationData;

  }


  @override
  Widget build(BuildContext context) {

    _firebaseService.users
        .doc(_firebaseService.user!.uid)
        .get()
        .then((DocumentSnapshot document) {
      if (document.exists) {
        if(document['address'] != "" || document['address'] != null){
          setState(() {
            loading = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(locationData: _locationData,)),
                  (route) => false
          );
        }else{
          setState(() {
            loading = true;
          });
        }
      }
    });

    showBottomScreen(context){
      getLocation().then((location){
        if(location!=null){
          showModalBottomSheet(
            backgroundColor: Colors.white,
            //isScrollControlled: true,
            //enableDrag: true,
            context: context,
            builder: (context){
              return Column(
                children: [
                  /*const SizedBox(
                  height: 30.0,
                ),*/
                  AppBar(
                    automaticallyImplyLeading: false,
                    iconTheme: const IconThemeData(
                      color: Colors.black,
                    ),
                    elevation: 1.0,
                    backgroundColor: Colors.white,
                    title: Row(
                      children: [
                        IconButton(
                          onPressed:() {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          'Location',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: TextFormField(

                        decoration: const InputDecoration(
                          hoverColor: Colors.black,
                          hintText: 'Search City, area or Neighbourhood',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          icon: Icon(Icons.search),
                        ),
                      ),

                    ),
                  ),
                  ListTile(
                    horizontalTitleGap: 0.0,
                    onTap: (){
                      if(location != null){
                        _firebaseService.updateUser(
                            {
                               'location' : GeoPoint(location.latitude!, location.longitude!),
                              'address' : address,
                              'state' : stateValue,
                              'city' : cityValue,
                              'country' : countryValue,
                            },
                            context,
                        ).then((value){
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen(locationData: _locationData,)),
                                  (route) => false
                          );
                        });
                      }
                    },
                    leading: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                    ),
                    title: const Text(
                      'Use current Location',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      // ignore: unnecessary_null_comparison
                      location == null ? 'Fetching Location' : address,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade300,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        bottom: 4.0,
                        top: 4.0,
                        right: 0.0,
                      ),
                      child: Text(
                        'CHOOSE CITY',
                        style: TextStyle(
                          color: Colors.blueGrey.shade900,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    child: CSCPicker(
                      layout: Layout.vertical,
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.ENABLE,
                      dropdownDecoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(const Radius.circular(10)),
                          color: Colors.white60,
                          border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                      /*countrySearchPlaceholder: "Country",
                      stateSearchPlaceholder: "State",
                      citySearchPlaceholder: "City",

                      countryDropdownLabel: "Country",
                      stateDropdownLabel: "State",
                      cityDropdownLabel: "City",*/

                      defaultCountry: DefaultCountry.India,

                      ///Disable country dropdown (Note: use it with default country)
                      //disableCountry: true,

                      selectedItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      dropdownHeadingStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),

                      dropdownItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      dropdownDialogRadius: 10.0,
                      searchBarRadius: 10.0,
                      onCountryChanged: (value) {
                        setState(() {
                          ///store value in country variable
                          print(value);
                          countryValue = value;

                        });
                      },

                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value == null ? "" : value;
                        });
                      },

                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value == null ? "" : value;
                          manualAddress = cityValue + "," + stateValue + "," + countryValue.substring(8);
                           if(value != null){
                             _firebaseService.updateUser(
                                 {
                                   'address' : manualAddress,
                                   'state' : stateValue,
                                   'city' : cityValue,
                                   'country' : countryValue,
                                 },
                                 context
                             ).then((value) {
                               Navigator.pushAndRemoveUntil(
                                   context,
                                   MaterialPageRoute(builder: (context) => HomeScreen(locationData: _locationData,)),
                                       (route) => false
                               );
                             });
                           }
                        });
                      },
                    ),

                  ),
                ],
              );
            },
          );
        }else{

        }
      });

    }

    showAlertDialog(BuildContext context){
      AlertDialog alertDialog = AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
            const SizedBox(
              width: 20.0,
            ),
            const Text('Fetching Location...')
          ],
        ),
      );
      showDialog(barrierDismissible: false, context: context, builder: (BuildContext context){
        return alertDialog;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          !loading ? const CircularProgressIndicator() :Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: !loading?
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
                                _firebaseService.updateUser(
                                    {
                                      'address' : address,
                                      'state' : stateValue,
                                      'city' : cityValue,
                                      'country' : countryValue,
                                    },
                                    context
                                ).then((value) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomeScreen(locationData: _locationData,)),
                                          (route) => false
                                  );
                                });
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
              InkWell(
                onTap: (){
                  showAlertDialog(context);
                  showBottomScreen(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Colors.cyan.shade100,
                          ),

                        )
                    ),
                    child: Text(
                      'Set location Manually',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan.shade200,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}
