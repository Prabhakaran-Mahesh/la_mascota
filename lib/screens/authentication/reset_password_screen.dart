
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/screens/authentication/email_auth_screen.dart';
import 'package:la_mascota/screens/location_screen.dart';
import 'package:open_mail_app/open_mail_app.dart';

class PasswordResetScreen extends StatelessWidget {
  static const String id = 'PasswordScreenId';
  const PasswordResetScreen({Key? key}) : super(key: key);

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.lock,
                      size: 35,
                        color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 7.0,
                    ),
                    Text(
                      'Forget Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Check you email, we will send link to reset your Password',
                   style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value){
                    final bool isValid = EmailValidator.validate(emailController.text);
                    if(value == null || value.isEmpty){
                      return 'Enter Email';
                    }
                    if(value.isNotEmpty && isValid == false){
                      return 'Enter a valid Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      labelText: 'Registered Email',
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
            onPressed: (){
              //_validateEmail();
              if(_formKey.currentState!.validate()){
                FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value){
                  Navigator.pushReplacementNamed(context, EmailAuthScreen.id);
                });
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
