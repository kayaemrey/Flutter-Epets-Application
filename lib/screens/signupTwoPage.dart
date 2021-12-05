import 'package:epetsapp/screens/loginpage.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class signuptwo extends StatefulWidget {
  @override
  _signuptwoState createState() => _signuptwoState();
}

class _signuptwoState extends State<signuptwo> {

  TextEditingController t1= TextEditingController();
  TextEditingController t2= TextEditingController();

  int selectedRadioTile;
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myFirebase = Provider.of<firebasedb>(context);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: t1,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  icon: Icon(Icons.person,color: Colors.black,),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: 1,
                      groupValue: selectedRadioTile,
                      title: Text("Hayvan sever"),
                      onChanged: (val) {
                        print("Radio Tile pressed $val");
                        setSelectedRadioTile(val);
                      },
                      activeColor: Colors.red,
                      //selected: true,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: 2,
                      groupValue: selectedRadioTile,
                      title: Text("Veteriner"),
                      onChanged: (val) {
                        print("Radio Tile pressed $val");
                        setSelectedRadioTile(val);
                      },
                      activeColor: Colors.red,
                      //selected: false,
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text("Next"),
              onPressed: (){
                if(t1.text.isEmpty && t2.text.isEmpty){
                  AlertDialog alert = AlertDialog(
                    title: Text("empty box"),
                    content: Text("Please do not leave blank the fields you need to enter."),
                    actions: [
                      TextButton(child: Text("okey"), onPressed: () {
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
                }else{
                  myFirebase.adduser(t1.text,selectedRadioTile.toString());
                  AlertDialog alert = AlertDialog(
                    title: Text("Activasyon message"),
                    content: Text("Please check the activation message sent to your e-mail and please confirm it."),
                    actions: [
                      TextButton(child: Text('Okey'), onPressed: () {
                        t1.clear();
                        t2.clear();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpage()));
                      }),
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
