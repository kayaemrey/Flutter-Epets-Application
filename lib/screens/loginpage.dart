import 'package:epetsapp/emergency/emergencypage.dart';
import 'package:epetsapp/inAppScreens/nearestClinicpage.dart';
import 'package:epetsapp/screens/forgotpasswordpage.dart';
import 'package:epetsapp/screens/signuppage.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/jsondataread.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController t1= TextEditingController();
  TextEditingController t2= TextEditingController();
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    return Scaffold(
      body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.13,),
                Image.asset("assets/images/veterinarian.png",width: 128,height: 128,),
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   maxRadius: 105,
                //   backgroundImage: AssetImage("assets/images/kapak1.jpg"),
                // ),
                SizedBox(height: 15,),
                Text("E-pets app",style: TextStyle(fontSize: 29),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: t1,
                    keyboardType: TextInputType.emailAddress,
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
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      icon: Icon(Icons.lock_open,color: Colors.black,),
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.only(right:12.0),
                  child: Container(
                    alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotpasswordpage()));
                        },
                          child: Text("forgot password?",style: TextStyle(fontSize: 16,color: Colors.green.shade800),)
                      )
                  ),
                ),
                SizedBox(height: 30,),
                RaisedButton(
                  color: Colors.blue.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11,horizontal: 80),
                    child: Text("LOGIN",style: TextStyle(fontSize: 25),),
                  ),
                  onPressed: (){
                    myAuth.signinuser(t1.text, t2.text);
                    myAuth.signinstatus(context);
                  },
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ?"),
                    InkWell(
                        child: Text("Signup here",style: TextStyle(color: Colors.blue),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>signuppage()));
                      },
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Column(
                        children: [
                          Image.asset("assets/images/emergy.png",width: 56,height: 56,),
                          Text("Acil"),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>emergencypage()));
                      },
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Image.asset("assets/images/veter.png",width: 56,height: 56,),
                          Text("En yakın klinik"),
                        ],
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MapSample()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
