import 'package:flutter/material.dart';
import 'package:flash_chat/components/round_button.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'login_screen.dart';


class ResetScreen extends StatefulWidget {
  static const String id='reset_screen';
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {

  final _auth=FirebaseAuth.instance;
  String email;
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
                  height: 24.0,
                ),
                RoundButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Send Request',
                  onpressed: () async{
                    setState(() {
                      showSpinner=true;
                    });
                    try{
                    _auth.sendPasswordResetEmail(email: email);
                      Navigator.pushNamed(context, LoginScreen.id);
                    Alert(
                      context: context,
                      title: "Sent!",
                      desc: "An Email has been sent to reset your password.",
                      image: Image.asset("images/success.png"),
                    ).show();

                      setState(() {
                        showSpinner=false;
                      });
                    }
                    catch(e){
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
