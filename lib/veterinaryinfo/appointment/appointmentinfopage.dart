import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:epetsapp/services/firebaseStorage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/appointment/appointmentinpage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/appointment/appointmentsearchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class appointmentinfopage extends StatefulWidget {

  @override
  _appointmentinfopageState createState() => _appointmentinfopageState();
}

class _appointmentinfopageState extends State<appointmentinfopage> {
  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    final myStorage = Provider.of<firebasestorage>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(myAuth.authid()).collection("veterinarappointment");

    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy("kayittarihi",descending: true).snapshots(),
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
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>appointmentsearchpage()));
                },
                iconSize: 30,
              ),
              IconButton(
                icon: Icon(Icons.add),
                color: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>appointmentinpage()));
                },
                iconSize: 30,
              )
            ],
          ),
          body: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius:BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Müşteri adı: "+document.data()["müşteriname"],style: TextStyle(fontSize: 18),),
                            Text("Hasta adı: "+document.data()["hastaname"],style: TextStyle(fontSize: 18),),
                            Row(
                              children: [
                                Text("Türü: "+document.data()["tür"],style: TextStyle(fontSize: 18),),
                                SizedBox(width: 10,),
                                Text("Irkı: "+document.data()["irk"],style: TextStyle(fontSize: 18),),
                              ],
                            ),
                            Text("Teşhis veya Not: "+document.data()["not"],style: TextStyle(fontSize: 18),),
                            SizedBox(height: 5,),
                            Text(document.data()["kayittarihi"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onLongPress: (){
                    AlertDialog alert = AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),
                      backgroundColor: Colors.blue.shade400,
                      title: Text("Randevu silinsin mi?"),
                      actions: [
                        TextButton(child: Text("Hayır",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
                          Navigator.pop(context);
                        }),
                        TextButton(child: Text("Sil",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
                          myDB.deletevetinfo("veterinarappointment", document.id);
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
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
