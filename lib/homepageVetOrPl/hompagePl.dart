import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/petsinfo/notificationsinfopage.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class homepagepl extends StatefulWidget {
  @override
  _homepageplState createState() => _homepageplState();
}

class _homepageplState extends State<homepagepl> {
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(myAuth.authid()).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15,),
                CircleAvatar(
                  maxRadius: 75,
                  backgroundColor: Colors.white,
                  backgroundImage: data["profilepic"] == null ? AssetImage("assets/petsimages/cat.png") : NetworkImage(data["profilepic"]),),
                SizedBox(height: 10,),
                Text(data["name"], style: TextStyle(color: Colors.black, fontSize: 35)),
                Text("Hayvan sever", style: TextStyle(color: Colors.black, fontSize: 22)),
                Text("${data["il"]},${data["ilce"]}", style: TextStyle(color: Colors.black, fontSize: 20,)),
                SizedBox(height: 10,),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>notificationsinfopage()));
                    },
                    child: Image.asset("assets/petsimages/alarm.png",fit: BoxFit.cover,height: 64,width: 64,)
                ),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
