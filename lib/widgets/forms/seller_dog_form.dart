import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:la_mascota/provider/cat_provider.dart';
import 'package:la_mascota/services/firebase_Services.dart';
import 'package:provider/provider.dart';

class SellerHamsterForm extends StatefulWidget {
  SellerHamsterForm({Key? key}) : super(key: key);
  static const String id = 'DogsForm';

  @override
  State<SellerHamsterForm> createState() => _SellerHamsterFormState();
}

class _SellerHamsterFormState extends State<SellerHamsterForm> {
  //final image;
  final _formKey = GlobalKey<FormState>();

  FirebaseService _service = FirebaseService();

  var _breedController = TextEditingController();
  var _yearController = TextEditingController();
  var _priceController = TextEditingController();
  var _nameController = TextEditingController();
  var _descController = TextEditingController();
  var _addrController = TextEditingController();
  String _address = '';

  validate(){
    if(_formKey.currentState!.validate()){

    }
  }

  @override
  void initState() {
    _service.getUserData().then((value) {
      setState(() {
        _addrController.text = value['address'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var _catProvider = Provider.of<CategoryProvider>(context);

    Widget _appBar(){
      return AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          '${_catProvider.selectedCategory} > Breeds',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      );
    }

    Widget _breedList(){
      return Dialog(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _appBar(),
            Expanded(
              child: ListView.builder(
                itemCount: _catProvider.doc['subs'].length,
                  itemBuilder: (BuildContext context, int index){
                return ListTile(
                  onTap: (){
                    setState(() {
                      _breedController.text = _catProvider.doc['subs'][index];
                    });
                    Navigator.pop(context);
                  },
                  title: Text(_catProvider.doc['subs'][index]),
                );
              }),
            )
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: const Text(
          'Details about Pets',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image.network(image),
                  Text(
                      _catProvider.selectedCategory.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                    )
                  ),
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (BuildContext context){
                        return _breedList();
                      });
                    },
                    child: TextFormField(
                      controller: _breedController,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Variant / Breed',
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please complete the required field';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _yearController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete the required field';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete the required field';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      prefixText: 'Rs ',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete the required field';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLength: 5000,
                    controller: _descController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      prefixText: 'Mention the Key features and Talents!!',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete the required field';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Divider(color: Colors.grey,),
                  TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      counterText: 'Seller Address'
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please complete the required field';
                      }
                      return null;
                    },
                  ),
                  const Divider(color: Colors.grey),
                  InkWell(
                    onTap: (){

                    },
                    child: Neumorphic(
                      child: Container(
                        height: 40.0,
                        child: const Center(
                          child: Text(
                            'Upload Images',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 90.0,
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                      'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: (){
                  validate();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
