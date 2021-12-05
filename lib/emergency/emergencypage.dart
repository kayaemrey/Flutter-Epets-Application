import 'package:epetsapp/emergency/emergencypicturepage.dart';
import 'package:flutter/material.dart';

class emergencypage extends StatefulWidget {
  @override
  _emergencypageState createState() => _emergencypageState();
}

class _emergencypageState extends State<emergencypage> {
  TextEditingController txtaciklama = TextEditingController();
  TextEditingController txtkonu = TextEditingController();
  TextEditingController txtname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 70,
                controller: txtname,
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ad - Soyad giriniz",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 70,
                controller: txtkonu,
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Konuyu giriniz",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 4,
                maxLength: 200,
                controller: txtaciklama,
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Açıklama giriniz",
                ),
              ),
            ),
            RaisedButton(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:15,horizontal: 80),
                child: Text("İleri"),
              ),
              onPressed: (){
                if(txtname.text.isNotEmpty && txtkonu.text.isNotEmpty && txtaciklama.text.isNotEmpty){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>emergencypicturepage(txtname.text,txtkonu.text,txtaciklama.text)));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
