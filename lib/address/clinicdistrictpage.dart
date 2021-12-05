import 'package:epetsapp/inAppScreens/clinicpage.dart';
import 'package:epetsapp/inAppScreens/profilepage.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class clinicilcesayfasi extends StatelessWidget {
  final String documentId;

  clinicilcesayfasi(this.documentId);
  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('iller');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        int sayac = 0;
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          List ilceler = data["ilce"];
          return Scaffold(
            appBar: AppBar(
              title: const Text("E-pets"),
            ),
            body: Container(
              width: double.infinity,
              child: ListView.builder(
                itemCount: ilceler.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
                      myDB.addDataCilinicilce(data["ilce"][index]["ilce_adi"]);
                      Navigator.pop(context);
                    },
                    title: Center(child: Text(data["ilce"][index]["ilce_adi"])),
                  );
                },
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
