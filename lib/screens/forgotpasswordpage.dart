import 'package:epetsapp/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class forgotpasswordpage extends StatefulWidget {
  @override
  _forgotpasswordpageState createState() => _forgotpasswordpageState();
}

class _forgotpasswordpageState extends State<forgotpasswordpage> {
  TextEditingController txtmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter your E-mail",
                hintStyle: TextStyle(color: Colors.black),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                icon: Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          RaisedButton(
            color: Colors.blue.shade200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 80),
              child: Text("reset password"),
            ),
            onPressed: () {
              if(txtmail.text.isNotEmpty){
                myAuth.resetPassword(txtmail.text);
                txtmail.clear();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
