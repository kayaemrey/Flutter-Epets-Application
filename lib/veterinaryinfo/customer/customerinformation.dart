import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/customer/customerDataAddPAge.dart';
import 'package:flutter/material.dart';
class customerinformationpage extends StatefulWidget {
  final String documentId;
  customerinformationpage(this.documentId);
  @override
  _customerinformationpageState createState() => _customerinformationpageState();
}

class _customerinformationpageState extends State<customerinformationpage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users').doc(widget.documentId).collection("hayvanlar");

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
          body: ListView(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>customerdataaddpage(widget.documentId,document.id,)));
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
