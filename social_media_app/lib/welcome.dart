
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auths/controllers/authentications.dart';
import 'package:flutter_auths/pages/signupScreen.dart';
import 'package:flutter_auths/pages/tasks.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         child: Column(
        children: <Widget>[

        Container(

          child: Image(image: AssetImage(assetName),),
          ), //add logo when we get it
          RichText(
            text: TextSpan(
              text: "Welcome to ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
            )
          )
      ]
      )
      
      )
     
    );
  }
  // tutorial credit: https://www.youtube.com/channel/UCc8DBMjBouqHmxQYP1B90QA
}