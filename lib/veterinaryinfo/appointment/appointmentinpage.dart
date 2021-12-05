import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:epetsapp/services/firebaseStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class appointmentinpage extends StatefulWidget {
  @override
  _appointmentinpageState createState() => _appointmentinpageState();
}

class _appointmentinpageState extends State<appointmentinpage> {
  TextEditingController txtmkrcpno = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtpatientname = TextEditingController();
  TextEditingController txtpsptno = TextEditingController();
  TextEditingController txtirk = TextEditingController();
  TextEditingController txttur = TextEditingController();
  TextEditingController txttar = TextEditingController();
  TextEditingController txtsaat = TextEditingController();
  TextEditingController txtnot = TextEditingController();
  TextEditingController txtcnsyt = TextEditingController();
  TextEditingController txtdt = TextEditingController();

  String dropdownValue = 'Erkek';
  String birthDateInString;
  DateTime birthDate;

  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    final myStorage = Provider.of<firebasestorage>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: txtname,
                          //obscureText: true,
                          maxLength: 22,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Müşteri adını giriniz',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        child: TextField(
                          maxLength: 22,
                          controller: txtpatientname,
                          //obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Hasta adını giriniz',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                  child: Row(
                    children: [
                      //Text("Mikroçip no :", style: TextStyle(fontSize: 18),),
                      //SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: txtmkrcpno,
                            //obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mikroçip numarasını giriniz',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                  child: Row(
                    children: [
                      //Text("Passport no :", style: TextStyle(fontSize: 18),),
                      //SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: txtpsptno,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Passport numarasını giriniz',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: txttur,
                            //obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Türünü giriniz',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: txtirk,
                            //obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Irkını giriniz',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: txtcnsyt,
                            maxLength: 8,
                            //obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Cinsiyet giriniz',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: txtdt,
                            maxLength: 10,
                            keyboardType: TextInputType.datetime,
                            //obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'D.Tarihi giriniz',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                            labelText: 'Kayıt tarih',
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
                            labelText: 'Kayıt saat',
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
                SizedBox(height: 15,),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text("Kaydet"),
                  onPressed: (){
                    myDB.addappovet(txtname.text, txtpatientname.text, txtmkrcpno.text, txtpsptno.text,
                        txttur.text, txtirk.text, txtcnsyt.text, txtdt.text, txttar.text + " "+ txtsaat.text, txtnot.text);
                    txtname.clear();
                    txtpatientname.clear();
                    txtirk.clear();
                    txttur.clear();
                    txtmkrcpno.clear();
                    txtpsptno.clear();
                    txtcnsyt.clear();
                    txtdt.clear();
                    txttar.clear();
                    txtsaat.clear();
                    txtnot.clear();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
