import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_mascota/screens/authentication/email_auth_screen.dart';
import 'package:la_mascota/screens/authentication/email_verification_screen.dart';
import 'package:la_mascota/screens/authentication/google_auth.dart';
import 'package:la_mascota/screens/authentication/phoneauth_screen.dart';
import 'package:la_mascota/services/phoneauth_service.dart';

class AuthUi extends StatefulWidget {
  const AuthUi({Key? key}) : super(key: key);

  @override
  State<AuthUi> createState() => _AuthUiState();
}

class _AuthUiState extends State<AuthUi> {
  bool isSignIn = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  FacebookLogin facebookLogin = FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 320.0,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: (){
                Navigator.pushNamed(context, PhoneAuthScreen.id);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  const Icon(Icons.phone_android_outlined, color: Colors.black,),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text('Continue with Phone', style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  ),)
                ],
              ),
            ),
          ),
          SizedBox(
            width: 320,
            child: SignInButton(
              Buttons.Google,
              onPressed: ()async{
                User? user = await GoogleAuthentication.signInWithGoogle(context: context);
                if(user != null){
                  PhoneAuthService _authentication = PhoneAuthService();
                  _authentication.addUser(context);
                }
              },
              text: ('Continue with Google'),

            ),
          ),
          SizedBox(
            width: 320,
            child: SignInButton(
              Buttons.FacebookNew,
              onPressed: ()async{
                await handleLogin();
              },
              text: ('Continue with Facebook'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0,),
            child: Text(
              'OR',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0,),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, EmailAuthScreen.id);
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => EmailVerificationScreen()));
              },
              child: const Text(
                'Login with Email',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,decoration: TextDecoration.underline, fontSize: 17.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleLogin() async {
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
      case FacebookLoginStatus.loggedIn:
        try {
          await loginWithfacebook(result);
        } catch (e) {
          print(e);
        }
        break;
    }
  }

  Future loginWithfacebook(FacebookLoginResult result) async {
    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential =
    FacebookAuthProvider.credential(accessToken.token);
    var a = await _auth.signInWithCredential(credential);

    setState(() {
      _user = a.user;
    });

    if(_user != null){
      PhoneAuthService _authentication = PhoneAuthService();
      _authentication.addUser(context);
    }
  }

  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      setState(() {
        facebookLogin.logOut();
        isSignIn = false;
      });
    });
  }
}
