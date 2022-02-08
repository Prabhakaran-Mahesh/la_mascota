import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/categories/subCat_screen.dart';
import 'package:la_mascota/screens/sellItems/seller_subCat_screen.dart';
import 'package:la_mascota/services/firebase_Services.dart';

class SellerCategoryListScreen extends StatelessWidget {
  const SellerCategoryListScreen({Key? key}) : super(key: key);

  static const String id = 'SellerCategoryListScreen';

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();

    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: _service.categories.get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index){

                  var doc = snapshot.data!.docs[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: (){
                        if(doc['subCat'] == null){
                          return print('');
                        }
                        Navigator.pushNamed(context, SellerSubCatList.id, arguments: doc);
                      },
                      leading: Image.network(
                          doc['image'],
                        width: 40,
                      ),
                      title: Text(
                          doc['catName'],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
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