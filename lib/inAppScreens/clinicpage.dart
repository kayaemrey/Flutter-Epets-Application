import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/address/addClinicLocation.dart';
import 'package:epetsapp/address/clinicdistrictpage.dart';
import 'package:epetsapp/address/clinicprovincepage.dart';
import 'package:epetsapp/address/districtpage.dart';
import 'package:epetsapp/address/provincepage.dart';
import 'package:epetsapp/inAppScreens/drawerpage.dart';
import 'package:epetsapp/selectionSecreens/clinicpetpage.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class clinicpage extends StatefulWidget {
  @override
  _clinicpageState createState() => _clinicpageState();
}

class _clinicpageState extends State<clinicpage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();
  TextEditingController t6 = TextEditingController();
  TextEditingController t7 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(myAuth.authid().toString()).get(),
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
            body: data["klinik"] != null ? SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: t1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: data["klinik"]["klinikadi"] != null ? "Ünvan (${data["klinik"]["klinikadi"]})" : "Klinikadi giriniz",),
                                ),
                              ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextField(
                                controller: t2,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: data["klinik"]["unvan"] != null ? "unvan (${data["klinik"]["unvan"]})" : "unvan giriniz",),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t3,
                          decoration:
                          InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:  data["klinik"]["telno"] != null ? "Telefon numarası (${data["klinik"]["telno"]})" : "telefon numarasını giriniz",),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t4,
                          decoration:
                          InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: data["klinik"]["vergino"] != null ? "Vergi kimlik no (${data["klinik"]["vergino"]})" : "vergi kimlik numarasını giriniz",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t5,
                          decoration:
                          InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: data["klinik"]["webpage"] != null ? "İnternet sitesi (${data["klinik"]["webpage"]})": "İnternet sitesini giriniz",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t6,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: data["klinik"]["aciklama"] != null ? "Açıklama (${data["klinik"]["aciklama"]})" : "Açıklama giriniz",),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t7,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: data["klinik"]["açıkadres"] != null ? "Açık adres (${data["klinik"]["açıkadres"]})":"Açıkadres giriniz",),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text("il: ", style: TextStyle(fontSize: 18),),
                                  InkWell(
                                    child: Container(
                                      child: data["klinik"]["il"] == null ? Text("Unknown", style: TextStyle(fontSize: 18),) : Text(data["klinik"]["il"], style: TextStyle(fontSize: 18),),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => clinicprovincepage()));
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text("ilçe: ", style: TextStyle(fontSize: 18),),
                                  InkWell(
                                    child: Container(
                                      child: data["klinik"]["ilce"] == null ? Text("Unknown", style: TextStyle(fontSize: 18),) : Text(data["klinik"]["ilce"], style: TextStyle(fontSize: 18),),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => clinicilcesayfasi(data["klinik"]["il"])));
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Divider(color: Colors.black, height: 5,thickness: 1,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Center(
                          child: InkWell(
                            child: Text("Konum ekle", style: TextStyle(fontSize: 18),),
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => addcliniclocation(
                              data["klinik"]["klinikadi"],data["klinik"]["açıkadres"],data["klinik"]["telno"]
                            )));
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Divider(color: Colors.black, height: 5,thickness: 1,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Center(
                          child: InkWell(
                            child: Text("Baktığınız hayvan tipleri", style: TextStyle(fontSize: 18),),
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => clinipetcpage()));
                            },
                          ),
                        ),
                      ),
                      Divider(color: Colors.black, height: 5,thickness: 1,),
                      SizedBox(height: 10,),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text("Kaydet",style: TextStyle(fontSize: 16),),
                        onPressed: () {
                          myDB.addDataCol(
                            t1.text != "" ? t1.text : "",
                            t2.text != "" ? t2.text : "",
                            t3.text != "" ? t3.text : "",
                            t4.text != "" ? t4.text : "",
                            t5.text != "" ? t5.text : "",
                            t6.text != "" ? t6.text : "",
                            t7.text != "" ? t7.text : "",
                          );
                          t1.clear();
                          t2.clear();
                          t3.clear();
                          t4.clear();
                          t5.clear();
                          t6.clear();
                          t7.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ) : SingleChildScrollView(
              // Null ise dönen yer
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: t1,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Klinik adını giriniz",
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: TextField(
                                controller: t2,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "unvan giriniz",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t3,
                          decoration:
                          InputDecoration(
                            border: OutlineInputBorder(),
                            labelText:  "Telefon numarasını giriniz",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t4,
                          decoration:
                          InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "vergi numarasını giriniz",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t5,
                          decoration:
                          InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "İnternet sitesini giriniz",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t6,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Açıklama giriniz",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: TextField(
                          controller: t7,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Açık adres giriniz",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text("il: ", style: TextStyle(fontSize: 18),),
                                  InkWell(
                                    child: Container(
                                      child: Text("Bilinmiyor", style: TextStyle(fontSize: 18),),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => clinicprovincepage()));
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text("ilçe: ", style: TextStyle(fontSize: 18),),
                                  InkWell(
                                    child: Container(
                                      child: Text("Bilinmiyor", style: TextStyle(fontSize: 18),),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => clinicilcesayfasi(data["klinik"]["il"])));
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Divider(color: Colors.black, height: 5,thickness: 1,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Center(
                          child: InkWell(
                            child: Text("Konum ekle", style: TextStyle(fontSize: 18),),
                            onTap: () {
                              if(t7.text.isNotEmpty && t1.text.isNotEmpty && t3.text.isNotEmpty ){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => addcliniclocation(t7.text,t1.text,t3.text)));
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Divider(color: Colors.black, height: 5,thickness: 1,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Center(
                          child: InkWell(
                            child: Text("Baktığınız hayvan tipleri", style: TextStyle(fontSize: 18),),
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => clinipetcpage()));
                            },
                          ),
                        ),
                      ),
                      Divider(color: Colors.black, height: 5,thickness: 1,),
                      SizedBox(height: 10,),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text("Kaydet",style: TextStyle(fontSize: 16),),
                        onPressed: () {
                          myDB.addDataCol(
                            t1.text != "" ? t1.text : "",
                            t2.text != "" ? t2.text : "",
                            t3.text != "" ? t3.text : "",
                            t4.text != "" ? t4.text : "",
                            t5.text != "" ? t5.text : "",
                            t6.text != "" ? t6.text : "",
                            t7.text != "" ? t7.text : "",
                          );
                          t1.clear();
                          t2.clear();
                          t3.clear();
                          t4.clear();
                          t5.clear();
                          t6.clear();
                          t7.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
