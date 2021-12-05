import 'package:epetsapp/address/districtpage.dart';
import 'package:epetsapp/address/provincepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/inAppScreens/drawerpage.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:epetsapp/services/firebaseStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class profilepage extends StatefulWidget {
  @override
  _profilepageState createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  String dropdownValue = 'Erkek';
  String birthDateInString;
  DateTime birthDate;
  TextEditingController txtname = TextEditingController();
  TextEditingController txtkadi = TextEditingController();
  TextEditingController txtcepno = TextEditingController();
  TextEditingController txttc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    final myAuth = Provider.of<AuthService>(context);
    final myStorage = Provider.of<firebasestorage>(context);
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
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data["profilepic"] == null ? InkWell(
                              child: Center(
                                child: CircleAvatar(
                                  maxRadius: 75,
                                  backgroundImage: AssetImage("assets/petsimages/cat.png"),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              onTap: () {
                                myStorage.getImage();
                              },
                            ) : InkWell(
                              child: Center(
                                child: CircleAvatar(
                                  maxRadius: 80,
                                  backgroundImage: NetworkImage(data["profilepic"]),
                                ),
                              ),
                              onTap: () {
                                myStorage.getImage();
                              },
                            ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextField(
                                  controller: txtname,
                                  //obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Adınızı giriniz (${data["name"] == null ? "unknown" : data["name"]})',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextField(
                                  controller: txtkadi,
                                  //obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Kullanıcı adını giriniz (${data["name"] == null ? "unknown" : data["kullaniciadi"]})',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            //Text("Cep no:", style: TextStyle(fontSize: 18),),
                            //SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                child: TextField(
                                  controller: txtcepno,
                                  keyboardType: TextInputType.phone,
                                  //obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Telefon numaranızı giriniz (${data["telefonno"] == null ? "unknown" : data["telefonno"]})',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextField(
                                  controller: txttc,
                                  keyboardType: TextInputType.number,
                                  maxLength: 11,
                                  //obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "T.C No giriniz (${data["tcno"] == null ? "unknown" : data["tcno"]})",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12,),
                            InkWell(
                              child: Image.asset("assets/petsimages/question.png",height: 25,width: 25,color: Colors.black,),
                              onTap: (){
                                AlertDialog alert = AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                  ),
                                  backgroundColor: Colors.blue.shade400,
                                  title: Text("Neden T.C No istiyoruz?"),
                                  content: Text("T.C no istememizin nedeni ..."),
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
                            )
                          ],
                        ),
                      ),
                      Divider(color: Colors.black,height: 5,thickness: 1,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text("İl : ", style: TextStyle(fontSize: 18),),
                                  InkWell(
                                    child: Container(
                                      child: data["il"] == null ? Text("Unknown", style: TextStyle(fontSize: 18),) : Text(data["il"], style: TextStyle(fontSize: 18),),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => provincepage()));
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text("İlçe : ", style: TextStyle(fontSize: 18),),
                                  InkWell(
                                    child: Container(
                                      child: data["ilce"] == null
                                          ? Text(
                                              "Unknown",
                                              style: TextStyle(fontSize: 18),
                                            )
                                          : Text(
                                              data["ilce"],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ilcesayfasi(data["il"])));
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(color: Colors.black,height: 5,thickness: 1,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cinsiyet: ",
                              style: TextStyle(fontSize: 18),
                            ),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.black, fontSize: 18),
                              underline: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                  myDB.addData(newValue, "Cinsiyet");
                                });
                              },
                              items: <String>["Erkek", "Kadın"]
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black,height: 5,thickness: 1,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Doğum tarihi: ", style: TextStyle(fontSize: 18),),
                            GestureDetector(
                                child: data["dogum_tarihi"] == null ? Text("Unknown", style: TextStyle(fontSize: 18),) : Text(data["dogum_tarihi"], style: TextStyle(fontSize: 18),),
                                onTap: () async {
                                  final datePick = await showDatePicker(
                                      context: context,
                                      initialDate: new DateTime.now(),
                                      firstDate: new DateTime(1900),
                                      lastDate: new DateTime(2100));
                                  if (datePick != null && datePick != birthDate) {
                                    setState(() {
                                      birthDate = datePick;
                                      birthDateInString =
                                      "${birthDate.day}/${birthDate.month}/${birthDate.year}"; // 08/14/2019
                                      myDB.addData(
                                          birthDateInString, "dogum_tarihi");
                                    });
                                  }
                                }
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Text("Kaydet",style: TextStyle(fontSize: 18),),
                          onPressed: (){
                            myDB.adduserinfo(txtname.text,txtkadi.text,txtcepno.text, txttc.text);
                            txtname.clear();
                            txtkadi.clear();
                            txtcepno.clear();
                            txttc.clear();
                          },
                        ),
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
