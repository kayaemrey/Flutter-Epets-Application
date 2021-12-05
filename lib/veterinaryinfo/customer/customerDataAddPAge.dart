import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class customerdataaddpage extends StatefulWidget {

  final String documentpetId;
  final String documentId;
  customerdataaddpage(this.documentpetId,this.documentId);

  @override
  _customerdataaddpageState createState() => _customerdataaddpageState();
}

class _customerdataaddpageState extends State<customerdataaddpage> {
  TextEditingController txtasi = TextEditingController();
  TextEditingController txttar = TextEditingController();
  TextEditingController txtsaat = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("E-pets"),
        ),
        body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: txtasi,
                      maxLength: 10,
                      //obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Aşı giriniz',
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
                  SizedBox(height: 30,),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: (){
                      myDB.addPetsAsi(widget.documentpetId,widget.documentId,txtasi.text,txttar.text + " " + txtsaat.text);
                      txtsaat.clear();
                      txttar.clear();
                      txtasi.clear();
                      AlertDialog alert = AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        backgroundColor: Colors.blue.shade400,
                        title: Text("Aşınız eklendi"),
                        actions: [
                          TextButton(child: Text("Çık",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 60),
                      child: Text("Kaydet"),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}
