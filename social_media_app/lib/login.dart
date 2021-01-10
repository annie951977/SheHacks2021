import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/HomePage.dart';
import 'SignUp.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentification() async
  {
   
   _auth.authStateChanges().listen((user) { 

    if(user!= null)
    {
      print(user);

      Navigator.push(context, MaterialPageRoute(
        
        builder: (context)=>HomePage()));
    }

   });

  

  }
       @override
   void initState()
   {
     super.initState();
     this.checkAuthentification();
   }
  login()async
  {
    if(_formKey.currentState.validate())
    {
      
      _formKey.currentState.save();

      try{
      
        UserCredential user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      }

      catch(e)
      {
        showError(e.message);
        print(e);
      }

    }
  }

  showError(String errormessage){

   showDialog(
     
    context: context,
    builder: (BuildContext context)
    {
      return AlertDialog(

        title: Text('ERROR'),
        content: Text(errormessage),

        actions: <Widget>[
          FlatButton(
            
            onPressed: (){
              Navigator.of(context).pop();
            }, 
          
          
          child: Text('OK'))
        ],
      );
    }
   
   
   );

  }

  navigateToSignUp()async
  {

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5556F6),
      body: SingleChildScrollView(
              child: Container(

          child: Column(
           
            children: <Widget>[

              Container(

                height: 400,
                child: Image(image: AssetImage("images/logo1.png"),
                // fit: BoxFit.contain,
                ),
              ),
          
              Container(

                child: Form(
   
                 key: _formKey,
                 child: Column(
                  
                   children: <Widget>[

                     Container(

                       child: TextFormField(

                         validator: (input)
                         {
                            if(input.isEmpty)

                            return 'Enter Email';
                         },

                            decoration: InputDecoration(

                              labelText: 'Email',
                              prefixIcon:Icon(Icons.email)
                            ),

                            onSaved: (input) => _email = input

                         
                       ),
                     ),
                     Container(

                       child: TextFormField(

                         validator: (input)
                         {
                            if(input.length < 6)

                            return 'Provide a Minimum of 6 Characters';
                         },

                            decoration: InputDecoration(

                              labelText: 'Password',
                              prefixIcon:Icon(Icons.lock),
                            ),
                            obscureText: true,


                            onSaved: (input) => _password = input

                         
                       ),
                     ),
                     SizedBox(height:20),

                     RaisedButton(
                       padding: EdgeInsets.fromLTRB(70,10,70,10),
                      onPressed: login,
                      child: Text('Login',style: TextStyle(

                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                      
                      )),

                      color: Colors.white,
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(20.0),
                      ),
                     
                     )
                   ],
                 ),

                ),
              ),
                SizedBox(height : 20),
                SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {},
                ),
                SizedBox(height : 20),
              GestureDetector(
                child: Text('Create an Account?'),
                onTap: navigateToSignUp,
              )
            ],
          ),
        ),
      )
      
    );
  }
}