

import 'package:flutter/material.dart';
import 'package:la_mascota/screens/location_screen.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../login_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                'Check you email to verify your Registered Email',
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        ),
                        onPressed: ()async{
                          var result = await OpenMailApp.openMailApp();
                          if (!result.didOpen && !result.canOpen) {
                            showNoMailAppsDialog(context);

                            // iOS: if multiple mail apps found, show dialog to select.
                            // There is no native intent/default app system in iOS so
                            // you have to do it yourself.
                          } else if (!result.didOpen && result.canOpen) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return MailAppPickerDialog(
                                  mailApps: result.options,
                                );
                              },
                            );
                          }
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LocationScreen()), (route) => false);
                        },
                        child: const Text(
                          'Verify Email',
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
