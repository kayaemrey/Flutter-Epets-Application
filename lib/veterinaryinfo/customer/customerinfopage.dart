import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/customer/customerPage.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/customer/customerinformation.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/customer/customersearchpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class customerinfopage extends StatefulWidget {
  final String vetname;

  customerinfopage(this.vetname);
  @override
  _customerinfopageState createState() => _customerinfopageState();
}

class _customerinfopageState extends State<customerinfopage> {
  
  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(myAuth.authid()).collection("veterinarcustomer");

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
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>customersearchpage(widget.vetname)));
                },
                iconSize: 30,
              ),
              SizedBox(width: 5,),
              // IconButton(
              //   icon: Icon(Icons.add),
              //   color: Colors.white,
              //   onPressed: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>customerpage()));
              //   },
              //   iconSize: 30,
              // ),
              // SizedBox(width: 5,),
            ],
          ),
          body: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          SizedBox(width: 5,),
                          CircleAvatar(backgroundColor: Colors.white,maxRadius: 35,backgroundImage: document.data()["profilepic"] != null ? NetworkImage(document.data()["profilepic"]) : AssetImage("assets/petsimages/user.png")),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(document.data()["kullaniciadi"],style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
                              Text(document.data()["name"],style: TextStyle(fontSize: 14),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>customerinformationpage(document.data()["customerid"])));
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
