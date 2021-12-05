import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class notificationsinfopage extends StatefulWidget {
  @override
  _notificationsinfopageState createState() => _notificationsinfopageState();
}

class _notificationsinfopageState extends State<notificationsinfopage> {
  String kullaniciadi = "";
  String name = "";
  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(myAuth.authid()).collection("veterinars");
    CollectionReference user = FirebaseFirestore.instance.collection('users');

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
            title: Text("E-pets"),
          ),
          body: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: user.doc(myAuth.authid()).get(),
                builder:
                    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data.data();
                    kullaniciadi = data["kullaniciadi"];
                    name = data["name"];
                    return Container();
                  }

                  return Text("loading");
                },
              ),
              Expanded(
                child: ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Veteriner adı: " + document.data()['veteriner'],style: TextStyle(fontSize: 21),),
                                IconButton(
                                  iconSize: 25,
                                  icon: Icon(Icons.check_circle_outline,color: Colors.blue,),
                                  onPressed: (){
                                    myDB.addcustomerpet(document.data()['id'],myAuth.authid(),kullaniciadi,name);
                                    AlertDialog alert = AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25)
                                      ),
                                      backgroundColor: Colors.blue.shade400,
                                      title: Text("Veteriner onaylandı"),
                                      actions: [
                                        TextButton(child: Text("Çık",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
                                          myDB.deleteveruserpet(document.data()['id']);
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
                                  },
                                )
                              ],
                            ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
