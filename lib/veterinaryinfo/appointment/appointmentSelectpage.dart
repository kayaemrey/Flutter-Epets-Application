import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class appointmentselectpage extends StatefulWidget {
  final String docid;
  final String name;
  final String mikrocipno;
  final String passportno;
  final String irk;
  final String tur;
  final String cinsiyet;
  final String dtarihi;
  appointmentselectpage(this.docid,this.name,this.mikrocipno,this.passportno,this.irk,this.tur,this.cinsiyet,this.dtarihi);
  @override
  _appointmentselectpageState createState() => _appointmentselectpageState();
}

class _appointmentselectpageState extends State<appointmentselectpage> {
  TextEditingController txttar = TextEditingController();
  TextEditingController txtsaat = TextEditingController();
  TextEditingController txtnot = TextEditingController();
  String musname = "";
  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: Text("E-pets"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: users.doc(widget.docid).get(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      musname = data["name"];
                      return Container();
                    }

                    return Center(child: CircularProgressIndicator());
                  },
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                      child: TextField(
                        controller: txttar,
                        maxLength: 10,
                        //obscureText: true,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'randevu tarihi',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                      child: TextField(
                        controller: txtsaat,
                        maxLength: 5,
                        keyboardType: TextInputType.datetime,
                        //obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'randevu saati',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: txtnot,
                //obscureText: true,
                maxLines: 3,
                maxLength: 135,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Teşhis veya Not',
                ),
              ),
              RaisedButton(
                child: Text("Kaydet"),
                onPressed: (){
                  myDB.addappovet(musname == null ? "bilinmiyor":musname, widget.name == null ? "bilinmiyor":widget.name, widget.mikrocipno == null ? "bilinmiyor": widget.mikrocipno, widget.passportno == null ? "bilinmiyor": widget.passportno,
                      widget.tur == null ? "bilinmiyor": widget.tur, widget.irk == null ? "bilinmiyor": widget.irk, widget.cinsiyet == null ? "bilinmiyor": widget.cinsiyet, widget.dtarihi == null ? "bilinmiyor": widget.dtarihi, txttar.text == null ? "bilinmiyor":txttar.text  + " "+ txtsaat.text == null ? " ": txtsaat.text, txtnot.text == null ? "bilinmiyor":txtnot.text);
                  AlertDialog alert = AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    backgroundColor: Colors.blue.shade400,
                    title: Text("Randevu kaydedildi"),
                    actions: [
                      TextButton(child: Text("Çık",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
                        txtnot.clear();
                        txtsaat.clear();
                        txttar.clear();
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
            ],
          ),
        ),
      ),
    );
  }
}
