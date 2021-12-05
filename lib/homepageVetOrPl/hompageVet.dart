import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/agenda/agendaPage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/agenda/agendainfopage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/appointment/appointmentinfopage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/customer/customerPage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/customer/customerinfopage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/statistics/statisticsPage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/stock/stockPage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/stock/stockinfopage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class homepageVet extends StatefulWidget {
  @override
  _homepageVetState createState() => _homepageVetState();
}

class _homepageVetState extends State<homepageVet> {
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
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
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
                  Text("Veteriner", style: TextStyle(color: Colors.black, fontSize: 22)),
                  Text("${data["il"]},${data["ilce"]}", style: TextStyle(color: Colors.black, fontSize: 20,)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>appointmentinfopage()));
                              },
                              child: Image.asset("assets/petsimages/appointment.png",fit: BoxFit.cover,height: 64,width: 64,)
                          ),
                          Text("Rendevu\ntakvimi",textAlign: TextAlign.center,)
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>agendainfopage()));
                              },
                              child: Image.asset("assets/petsimages/deadline.png",fit: BoxFit.cover,height: 64,width: 64,)
                          ),
                          Text("Notlar"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Center(
                    child: Column(
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>stockinfopage()));
                            },
                            child: Image.asset("assets/petsimages/stock.png",fit: BoxFit.cover,height: 64,width: 64,)
                        ),
                        SizedBox(height: 2,),
                        Text("Stok takibi"),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>statisticspage()));
                              },
                              child: Image.asset("assets/petsimages/statistics.png",fit: BoxFit.cover,height: 64,width: 64,)
                          ),
                          SizedBox(height: 2,),
                          Text("istatistik")
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>customerinfopage(data["name"])));
                              },
                              child: Image.asset("assets/petsimages/costumer.png",fit: BoxFit.cover,height: 64,width: 64,)
                          ),
                          Text("Müşteri"),
                        ],
                      ),
                    ],
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
