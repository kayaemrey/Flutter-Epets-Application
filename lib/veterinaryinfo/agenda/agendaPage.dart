import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class agendapage extends StatefulWidget {
  @override
  _agendapageState createState() => _agendapageState();
}

class _agendapageState extends State<agendapage> {
  TextEditingController txtbas = TextEditingController();
  TextEditingController txtaciklama = TextEditingController();
  TextEditingController txttar = TextEditingController();
  TextEditingController txtsaat = TextEditingController();
  DateTime now = DateTime.now();

  //DateTime currentTime = new DateTime(now.year, now.month, now.day, now.hour, now.minute);
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  //obscureText: true,
                  maxLength: 50,
                  controller: txtbas,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Başlık',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  //obscureText: true,
                  controller: txtaciklama,
                  maxLines: 6,
                  maxLength: 150,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Açıklama',
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: txttar,
                        maxLength: 10,
                        //obscureText: true,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tarih',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: txtsaat,
                        maxLength: 5,
                        keyboardType: TextInputType.datetime,
                        //obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Saat',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Center(
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Kaydet",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    myDB.addAgenda(txtbas.text, txtaciklama.text, txttar.text + " "+ txtsaat.text);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
