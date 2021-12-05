import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/agenda/agendaPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class agendainfopage extends StatefulWidget {
  @override
  _agendainfopageState createState() => _agendainfopageState();
}

class _agendainfopageState extends State<agendainfopage> {
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(myAuth.authid()).collection("veterinarynots");

    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy("tarih", descending: true).snapshots(),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>agendapage()));
                },
                iconSize: 30,
              )
            ],
          ),
          body: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: InkWell(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade200,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(document.data()["başlık"],style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                            Text(document.data()["açıklama"]),
                            Row(
                              children: [
                                Text(document.data()["tarih"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    onLongPress: (){
                      AlertDialog alert = AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        backgroundColor: Colors.blue.shade400,
                        title: Text("Notunuz silinsin mi?"),
                        actions: [
                          TextButton(child: Text("Hayır",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
                            Navigator.pop(context);
                          }),
                          TextButton(child: Text("Sil",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
                            myDB.deletevetinfo("veterinarynots", document.id);
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
