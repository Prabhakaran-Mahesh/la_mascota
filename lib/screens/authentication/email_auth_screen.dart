import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_mascota/services/emailauth_service.dart';

class EmailAuthScreen extends StatefulWidget {
  static const String id = 'EmailAuthScreen';
  const EmailAuthScreen({Key? key}) : super(key: key);

  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  bool validate = false;
  bool _login = false;

  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  EmailAuthentication _service = EmailAuthentication();

  _validateEmail() {
    if(_formKey.currentState!.validate()){
      setState(() {
        validate = false;
      });
      _service.getAdminCredential(emailController.text, passwordController.text, _login, context).then((value) {
      });
    }
  }

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
      body: Form(
        key: _formKey,
        child: Padding(
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
              Text(
                'Enter to ${_login ? 'Login' : 'Register'}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                'Enter your Email and Password to ${_login ? 'Login' : 'Register'}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 10.0,
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
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),

                  )
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10.0),
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    )
                ),
                onChanged: (value) {
                  if(emailController.text.isNotEmpty){
                    if(value.length>3){
                      setState(() {
                        validate = true;
                      });
                    }
                    else{
                      setState(() {
                        validate = false;
                      });
                    }
                  }else{
                    setState(() {
                      validate = false;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Align(
                alignment: Alignment.centerRight,
                  child: Text(
                      'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
              ),
              Row(
                children: [
                  Text(
                      _login ? 'New Account ? ' : 'Already has an Account',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  TextButton(
                    child: Text(
                        _login ? 'Register' : 'Login',
                      style: TextStyle(
                          color : Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: (){
                      setState(() {
                        _login = !_login;
                      });
                    },
                  )
                ],
              )
            ],
          ),
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
                _validateEmail();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _login ? 'Login' : 'Register',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
