import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/Start.dart';
import 'messaging/form.dart';
import 'messaging/wall.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin= false;


  checkAuthentification() async{

    _auth.authStateChanges().listen((user) { 

      if(user ==null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Start()));
      }
    });
  }

  getUser() async{

    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if(firebaseUser !=null)
    {
      setState(() {
        this.user =firebaseUser;
        this.isloggedin=true;
      });
    }
  }

  signOut()async{

    _auth.signOut();
  }

  @override
  void initState(){
  super.initState();
    this.checkAuthentification();
    this.getUser();
  }
   void addMessage(String value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await widget.store.add({
        'author': user.displayName ?? 'Anonymous',
        'author_id': user.uid,
        'photo_url': user.photoURL ?? 'https://placehold.it/100x100',
        'timestamp': Timestamp.now().millisecondsSinceEpoch,
        'value': value,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


     body: Container(
       child: !isloggedin? CircularProgressIndicator(): 
       
       Column(
         children: <Widget>[

           SizedBox(height: 40.0),

           Container(

            height: 550,
            child: Image(image: AssetImage("images/sample.png"),
            fit: BoxFit.contain,
          ),
        ),     
          Container(
              child:  Column(
                children: <Widget>[
                   Row(
                    children: <Widget>[
                       Container(
                         child: RaisedButton(

               padding: EdgeInsets.fromLTRB(60,10,60,10),
                      onPressed: signOut,
                      child: Text('Signout',style: TextStyle(

                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                      
                      )),

                      color: const Color(0xff5556F6),
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(20.0),
                      ),
            )
                      ),
                      Container(
                        child:  RaisedButton(

               padding: EdgeInsets.fromLTRB(60,10,60,10),
                      onPressed: signOut, // TODO: add message
                          if (signOut)
            MessageForm(
              onSubmit: addMessage,
            )
                      child: Text('Message',style: TextStyle(

                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                      
                      )),

                      color: const Color(0xff5556F6),
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(20.0),
                      ),
            )
                       
                      ),
                    ],
                  ),
                ],
              ),

               ),
           
        ],
       ),
     )

    );
  }
}
