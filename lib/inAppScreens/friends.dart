import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/selectionSecreens/petsDBaddpage.dart';
import 'package:epetsapp/selectionSecreens/petsfriendadd.dart';
import 'package:epetsapp/selectionSecreens/petsinformation.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class friendspage extends StatefulWidget {
  @override
  _friendspageState createState() => _friendspageState();
}

class _friendspageState extends State<friendspage> {
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(myAuth.authid()).collection("hayvanlar");

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("E-pets"),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>petsdbaddpage()));
                },
                iconSize: 30,
              )
            ],
          ),
          body: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.amberAccent.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            document.data()["picture"] == null ? CircleAvatar(
                              maxRadius: 30,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage("assets/petsimages/pets.png"),
                            ) : CircleAvatar(
                              maxRadius: 30,
                              backgroundImage: NetworkImage(document.data()["picture"]),
                            ),
                            Text(document.data()["name"],style: TextStyle(fontSize: 18),),
                            Column(
                              children: [
                                Text("Tür: " + document.data()["tur"],style: TextStyle(fontSize: 18),),
                                Text("Irk: " +document.data()["irk"],style: TextStyle(fontSize: 18),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>petsinfo(document.id)));
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
