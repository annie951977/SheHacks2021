import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

 FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 String _name, _email, _password;

 checkAuthentication() async {


    _auth.authStateChanges().listen((user) async 
    {
      if(user != null)
      {
       Navigator.push(context, MaterialPageRoute(
        
        builder: (context)=>HomePage()));
    }
    }
    );
  }

  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
  }

  signUp()async{

   if(_formKey.currentState.validate())
   {
     _formKey.currentState.save();

     try{
       UserCredential user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
       if(user!= null) 
       {
          await _auth.currentUser.updateProfile(displayName: _name);
       }
     }
     catch(e){
       
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
                fit: BoxFit.contain,
                ),
              ),
              RichText(
              text: TextSpan(
              text: 'Register',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,),

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

                            return 'Enter Name';
                         },

                            decoration: InputDecoration(

                              labelText: 'Name',
                              prefixIcon:Icon(Icons.person),
                            ),


                            onSaved: (input) => _name = input

                         
                       ),
                     ),

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

                            return 'Provide Minimum 6 Character';
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
                      onPressed: signUp,
                      child: Text('Sign Up',style: TextStyle(

                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                      
                      )),

                      color: const Color(0xff74D4DD),
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(20.0),
                      ),
                     
                     )
                   ],
                 ),

                ),
              ),
              SizedBox(height:20),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () {},
                ),
          ],
          ),
        ),
        
      )
      
    );
  }
}
