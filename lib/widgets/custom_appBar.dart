
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/location_screen.dart';
import 'package:la_mascota/services/firebase_Services.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();

    return FutureBuilder<DocumentSnapshot>(
      future: _service.users.doc(_service.user!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Address not Selected");
        }

        if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          if(data['address'] == null){
            if(data['state'] == null){
              GeoPoint latlong = data['location'];
              _service.getAddress(latlong.latitude, latlong.longitude)
              .then((address){
               return appBar(address, context);
              });
            }
          }
          else{
            return appBar(data['address'], context);
          }
          return appBar('Update Location', context);
        }

        return Text("loading");
      },
    );
  }

  Widget appBar(address, context){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1.0,
      title: InkWell(
        onTap: (){
          Navigator.pushNamed(context, LocationScreen.id);
        },
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
    );
  }
}
