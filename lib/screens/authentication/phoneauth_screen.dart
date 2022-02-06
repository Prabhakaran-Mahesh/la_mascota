import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/services/phoneauth_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  static const String id = 'PhoneAuthScreen';

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

  var countryCodeController = TextEditingController(text: '+91');
  var phoneNumberController = TextEditingController();

  bool validate = false; 

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
          const Text('Please wait')
        ],
      ),
    );
    showDialog(barrierDismissible: false, context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  PhoneAuthService _service = PhoneAuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text('Login', style: TextStyle(color: Colors.black,),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40.0,
            ),
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.red.shade200,
              child: const Icon(
                CupertinoIcons.person_alt_circle,
                color: Colors.red,
                size: 60.0,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              'Enter your Phone Number',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Text(
              'We will send Confirmation code to your phone',
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: countryCodeController,
                    enabled: false,
                    decoration: const InputDecoration(
                      counterText: '10',
                      labelText: 'Country',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    onChanged: (value){
                      if(value.length == 10){
                        setState(() {
                          validate = true;
                        });
                      }
                      else{
                        setState(() {
                          validate = false;
                        });
                      }
                    },
                    autofocus: true,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Number',
                      hintText: 'Enter your phone number',
                      hintStyle: TextStyle(fontSize: 10.0, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: AbsorbPointer(
            absorbing: validate ? false: true,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(validate ? Theme.of(context).primaryColor : Colors.grey),
              ),
              onPressed: (){
                String number = '${countryCodeController.text}${phoneNumberController.text}';
                showAlertDialog(context);
                _service.verifyPhoneNumber(context, number);
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
