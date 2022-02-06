import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/authentication/phoneauth_screen.dart';
import 'package:la_mascota/screens/location_screen.dart';
import 'package:la_mascota/services/phoneauth_service.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.number, required this.verId}) : super(key: key);
  final String number;
  final String verId;

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  bool _loading = false;

  PhoneAuthService _service = PhoneAuthService();

  final _text1 = TextEditingController();
  final _text2 = TextEditingController();
  final _text3 = TextEditingController();
  final _text4 = TextEditingController();
  final _text5 = TextEditingController();
  final _text6 = TextEditingController();

  // ignore: non_constant_identifier_names
  Future<void>PhoneCredential(BuildContext context, String otp)async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verId, smsCode: otp);

      final User? user = (await _auth.signInWithCredential(credential)).user;
      //print("USER :: "  + user.toString());

      if(user != null){
        _service.addUser(context);
      }
      else{
        if (kDebugMode) {
          print("Failed");
        }
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final node  = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: const Text('Login', style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0,),
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.red.shade200,
              child: const Icon(
                CupertinoIcons.person_alt_circle,
                color: Colors.red,
                size: 60.0,
              ),
            ),
            const SizedBox(height: 10.0,),
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: 'We sent a 6-digit code to ',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,

                        ),
                        children: [
                          TextSpan(
                              text: widget.number,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12.0,
                              )
                          )
                        ]
                    ),

                  ),
                ),
                InkWell(
                    child: const Icon(Icons.edit),
                  onTap: (){
                      Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _text1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _text2,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _text3,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _text4,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _text5,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (value){
                      if(value.length==1){
                        node.nextFocus();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _text6,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: (value){
                      if(value.length==1){
                        if(_text1.text.length == 1){
                          if(_text2.text.length == 1){
                            if(_text3.text.length == 1){
                              if(_text4.text.length == 1){
                                if(_text5.text.length == 1){
                                  setState(() {
                                    _loading = true;
                                  });
                                  String _otp = '${_text1.text}${_text2.text}${_text3.text}${_text4.text}${_text5.text}${_text6.text}';
                                  PhoneCredential(context, _otp);
                                }
                              }
                            }
                          }
                        }
                      }
                      else{
                        setState(() {
                          _loading = false;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            if(_loading)
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 50,
                  height: 5,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
