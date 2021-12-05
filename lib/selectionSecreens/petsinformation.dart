import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/petsinfo/deadlinePage.dart';
import 'package:epetsapp/petsinfo/medicinePage.dart';
import 'package:epetsapp/petsinfo/vaccinePage.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class petsinfo extends StatefulWidget {
  final String documentId;
  petsinfo(this.documentId);
  @override
  _petsinfoState createState() => _petsinfoState();
}

class _petsinfoState extends State<petsinfo> {

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(myAuth.authid()).collection("hayvanlar");

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Scaffold(
            appBar: AppBar(
              title: const Text("E-pets"),
            ),
            body: Container(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  Center(
                    child: CircleAvatar(
                      maxRadius: 75,
                      backgroundImage: data["picture"] == null ? AssetImage("assets/petsimages/pets.png") : NetworkImage(data["picture"]),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.035,),
                  Text("Adı: "+data["name"],style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5,),
                  Text("Mikroçip no: " +data["mikrocipno"],style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5,),
                  Text("Passport no: " + data["passportno"],style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5,),
                  Text("Türü: " + data["tur"]  + " - " + "Irkı: " + data["irk"],style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5,),
                  Text("Cinsiyet : " + data["cinsiyet"]  + " - " + "D.Tarihi : " + data["dtarihi"],style: TextStyle(fontSize: 20),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>medicinepage()));
                          },
                          child: Image.asset("assets/petsimages/medicine.png",fit: BoxFit.cover,height: 64,width: 64,)
                      ),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>deadlinepage()));
                          },
                          child: Image.asset("assets/petsimages/deadline.png",fit: BoxFit.cover,height: 64,width: 64,)
                      ),
                    ],
                  ),
                  Center(
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>vaccinepage()));
                        },
                        child: Image.asset("assets/petsimages/vaccine.png",fit: BoxFit.cover,height: 64,width: 64,)
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
