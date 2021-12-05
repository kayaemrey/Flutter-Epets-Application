import 'package:epetsapp/inAppScreens/profilepage.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class provincepage extends StatefulWidget {
  @override
  _provincepageState createState() => _provincepageState();
}

class _provincepageState extends State<provincepage> {
  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('iller');

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
          ),
          body: Container(
            width: double.infinity,
            child: ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new ListTile(
                  title: InkWell(
                    child: Container(
                        child: Center(
                            child: Text(document.id,style: TextStyle(fontSize: 20),)
                        )
                    ),
                    onTap: (){
                      myDB.addData(document.id,"il");
                      Navigator.pop(context);
                      },
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
