import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/services/firebase_Services.dart';

class SubCatList extends StatelessWidget {
  const SubCatList({Key? key}) : super(key: key);
  static const String id = 'SubCatScreen';

  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();
    final args = ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          args['catName'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<DocumentSnapshot>(
          future: _service.categories.doc(args.id).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }

            var data = snapshot.data!['subCat'];
            return Container(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListTile(
                      onTap: (){
                      },
                      title: Text(
                        data[index],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
