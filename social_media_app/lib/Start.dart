
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:social_media_app/Login.dart';
import 'SignUp.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
} // https://flutterigniter.com/using-hexadecimal-color-strings/

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  navigateToLogin()async{

    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
  }

   navigateToRegister()async{

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: "#5556F6".toColor(),
      body: Container(
        child: Column(
          children: <Widget>[

            SizedBox(height: 35.0),

            Container(
              height: 400,

              child: Image(image: AssetImage("images/12-120520_captain-marvel-clipart-clip-art-captain-marvel-clipart.png"),
              fit: BoxFit.contain,
              ),
            ),

            SizedBox(height : 20),
            SizedBox(height: 10.0),

            Text('Connect. Network. Mentor',style: TextStyle(color:Colors.white),),

            SizedBox(height: 70),


            Column( mainAxisAlignment: MainAxisAlignment.center,
                
              children: <Widget>[
                
                RaisedButton(
                  padding: EdgeInsets.only(left:100,right:100),
                  
                  onPressed: navigateToLogin,
                  child: Text('Login',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  ),),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white
                ),

                SizedBox(width:20.0),

                TextButton(
                
                  onPressed: navigateToRegister,
                  child: Text('Sign Up',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  ),),

                )

              ],
            ),

            
                // SizedBox(height : 20.0),

                // SignInButton(
                // Buttons.Google,
                // text: "Sign up with Google",
                // onPressed: () {},
             
          ],
        ),
      ),
      
    );
  }
  // credit: 
}