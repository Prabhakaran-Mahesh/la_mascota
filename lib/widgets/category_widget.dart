import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/categories/category_list.dart';
import 'package:la_mascota/services/firebase_Services.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();
    return Container(
      child: FutureBuilder<QuerySnapshot>(
        future: _service.categories.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //color: Colors.grey,
              height: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Categories'
                        ),
                      ),
                      TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, CategoryListScreen.id);
                          },
                          child: Row(
                            children: const [
                              Text(
                                'see all',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 12.0,color: Colors.black,)
                            ],
                          )
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index){

                        var doc = snapshot.data!.docs[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 60,
                            height: 50,
                            child: Column(
                              children: [
                                Image.network(doc['image']),
                                Flexible(
                                  child: Text(
                                    doc['catName'].toUpperCase(),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        },
                    ),
                  )
                ],
              )
            ),
          );
        },
      ),
    );
  }
}
