import 'package:flash_chat/screens/reset_passwrd_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/round_button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static const String id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth=FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "images/bg_messages.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email=value;
                  },
                  decoration: kInputdecoration.copyWith(
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password=value;
                  },
                  decoration: kInputdecoration.copyWith(
                    hintText: 'Enter your password.',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Log In',
                  onpressed: () async{
                    setState(() {
                      showSpinner=true;
                    });
                    try{
                      final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(user!=null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showSpinner=false;
                      });
                    }
                    catch(e){
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Error",
                        desc: "No User found",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show();
                      setState(() {
                        showSpinner=false;
                      });
                    }
                  },
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, ResetScreen.id);
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
