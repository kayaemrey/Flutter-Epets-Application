import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/homepageVetOrPl/hompagePl.dart';
import 'package:epetsapp/homepageVetOrPl/hompageVet.dart';
import 'package:epetsapp/inAppScreens/drawerpage.dart';
import 'package:epetsapp/inAppScreens/profilepage.dart';
import 'package:epetsapp/inAppScreens/profilepage.dart';
import 'package:epetsapp/inAppScreens/settingspage.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:epetsapp/services/jsondataread.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
 
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
    final myjson = Provider.of<jsondataread>(context);
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
          return Scaffold(
            drawer: drawerpage(),
            appBar: AppBar(
              title: const Text("E-pets"),
            ),
            body: data["tip"] == "1" ? homepagepl() : homepageVet(),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

