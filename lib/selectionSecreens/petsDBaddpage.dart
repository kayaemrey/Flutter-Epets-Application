import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:epetsapp/services/firebaseStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class petsdbaddpage extends StatefulWidget {
  @override
  _petsdbaddpageState createState() => _petsdbaddpageState();
}

class _petsdbaddpageState extends State<petsdbaddpage> {
  TextEditingController txtmkrcpno = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtpsptno = TextEditingController();
  TextEditingController txtirk = TextEditingController();
  TextEditingController txttur = TextEditingController();

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
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                Padding(
                  padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                  child: Row(
                    children: [
                      //Text("İsim :", style: TextStyle(fontSize: 18),),
                      //SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: txtname,
                            //obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Adını giriniz',
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
                            //obscureText: true,
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
                  padding: const EdgeInsets.only(right: 8,top: 2,bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text("Cinsiyet :",style: TextStyle(fontSize: 18),),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.black,fontSize: 18),
                              underline: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;

                                });
                              },
                              items: <String>["Erkek", "Dişi"]
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
                      Container(
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Doğum tarihi :",style: TextStyle(fontSize: 18),),
                            //data["dogum_tarihi"] == null ? Text("Unknown", style: TextStyle(fontSize: 25),) : Text(data["dogum_tarihi"], style: TextStyle(fontSize: 25),),
                            GestureDetector(
                                child: new Icon(Icons.calendar_today),
                                onTap: ()async{
                                  final datePick= await showDatePicker(
                                      context: context,
                                      initialDate: new DateTime.now(),
                                      firstDate: new DateTime(1900),
                                      lastDate: new DateTime(2100)
                                  );
                                  if(datePick!=null && datePick!=birthDate){
                                    setState(() {
                                      birthDate=datePick;
                                      birthDateInString = "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                                    });
                                  }
                                }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black, height: 5,thickness: 1,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                      child: Text("Fotoğraf ekle",style: TextStyle(fontSize: 18),),
                    onTap: (){
                        myStorage.getImagePet(txtname.text + txtmkrcpno.text,txtmkrcpno.text);
                    },
                  ),
                ),
                Divider(color: Colors.black, height: 5,thickness: 1,),
                SizedBox(height: 15,),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text("Kaydet"),
                  onPressed: (){
                      myDB.addpetuser(txtname.text, txtmkrcpno.text, txtpsptno.text, txttur.text, txtirk.text, dropdownValue, birthDateInString);
                      myDB.addpethayvanlar("hayvanlar", txtname.text, txtmkrcpno.text, txtpsptno.text, txttur.text, txtirk.text, dropdownValue, birthDateInString);
                      txtname.clear();
                      txtirk.clear();
                      txttur.clear();
                      txtmkrcpno.clear();
                      txtpsptno.clear();
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
