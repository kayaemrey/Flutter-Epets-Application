import 'file:///D:/flutterapps/epetsapp/lib/veterinaryinfo/stock/stockPage.dart';
import 'package:flutter/material.dart';

class stockinfopage extends StatefulWidget {
  @override
  _stockinfopageState createState() => _stockinfopageState();
}

class _stockinfopageState extends State<stockinfopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>stockvetpage()));
            },
            iconSize: 30,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
