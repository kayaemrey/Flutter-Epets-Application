import 'package:epetsapp/screens/loginpage.dart';
import 'package:epetsapp/screens/signupTwoPage.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:epetsapp/services/jsondataread.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signuppage extends StatefulWidget {
  @override
  _signuppageState createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  TextEditingController t1= TextEditingController();
  TextEditingController t2= TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myFirebase = Provider.of<firebasedb>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    hintText: "Enter your E-mail",
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    icon: Icon(Icons.mail,color: Colors.black,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: t2,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    icon: Icon(Icons.lock_open,color: Colors.black,),
                  ),
                ),
              ),
              RaisedButton(
                child: Text("Next"),
                onPressed: (){
                  if(t1.text.isEmpty && t2.text.isEmpty){
                    AlertDialog alert = AlertDialog(
                      title: Text("empty box"),
                      content: Text("Please do not leave blank the fields you need to enter."),
                      actions: [
                        TextButton(child: Text("okey"), onPressed: () {
                          Navigator.pop(context);
                        }),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }else{
                    myAuth.createuser(t1.text, t2.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>signuptwo()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
