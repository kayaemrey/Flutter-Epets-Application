import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/appointment/appointmentaddpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class appointmentsearchpage extends StatefulWidget {
  @override
  _appointmentsearchpageState createState() => _appointmentsearchpageState();
}

class _appointmentsearchpageState extends State<appointmentsearchpage> {

  TextEditingController txtsearch = TextEditingController();

  String name = "name";
  @override
  Widget build(BuildContext context) {

    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(myAuth.authid()).collection("veterinarcustomer");
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
          controller: txtsearch,
          decoration: InputDecoration(
            labelText: "Kullanıcı ara",
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: users.orderBy('kullaniciadi')
                  .startAt([name])
                  .endAt([name + '\uf8ff']).snapshots(),
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
                          height: MediaQuery.of(context).size.height * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(22)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 5,),
                                      document.data()["profilepic"] != null ? CircleAvatar(maxRadius: 35,backgroundImage: NetworkImage(document.data()["profilepic"])) : Container(),
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
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>appointmentaddpage(document.data()["customerid"])));
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
