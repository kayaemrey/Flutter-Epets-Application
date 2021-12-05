import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/appointment/appointmentSelectpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class appointmentaddpage extends StatefulWidget {
  final String documentId;
  appointmentaddpage(this.documentId);
  @override
  _appointmentaddpageState createState() => _appointmentaddpageState();
}

class _appointmentaddpageState extends State<appointmentaddpage> {
  TextEditingController txtmkrcpno = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtpatientname = TextEditingController();
  TextEditingController txtpsptno = TextEditingController();
  TextEditingController txtirk = TextEditingController();
  TextEditingController txttur = TextEditingController();
  TextEditingController txttar = TextEditingController();
  TextEditingController txtsaat = TextEditingController();
  TextEditingController txtnot = TextEditingController();
  TextEditingController txtcnsyt = TextEditingController();
  TextEditingController txtdt = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(widget.documentId).collection("hayvanlar");

    return Scaffold(
      appBar: AppBar(
        title: Text("E-pets"),
      ),
      body:  Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: users.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent.shade100,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Adı :"+document.data()["name"],style: TextStyle(fontSize: 18),),
                                Text("Mikrocipno :"+document.data()["mikrocipno"],style: TextStyle(fontSize: 18),),
                                Text("Passportno :"+document.data()["passportno"],style: TextStyle(fontSize: 18),),
                                Text("Tür :"+document.data()["tur"],style: TextStyle(fontSize: 18),),
                                Text("İrk :"+document.data()["irk"],style: TextStyle(fontSize: 18),),
                                Text("Cinsiyet :"+document.data()["cinsiyet"],style: TextStyle(fontSize: 18),),
                                Text("D.Tarihi :"+document.data()["dtarihi"],style: TextStyle(fontSize: 18),),
                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>appointmentselectpage(widget.documentId,
                            document.data()["name"],document.data()["mikrocipno"],document.data()["passportno"],
                              document.data()["irk"],document.data()["tur"],document.data()["cinsiyet"],document.data()["dtarihi"])));
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
