import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class statisticspage extends StatefulWidget {
  @override
  _statisticspageState createState() => _statisticspageState();
}

class _statisticspageState extends State<statisticspage> {

  List yazilar = [
    "Toplam rendevu sayısı",
    "Toplam müşteri sayısı",
    "Toplam stok sayısı",
  ];
  List sayilar = [
    1,0,0
  ];
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.29,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.orange.shade800,
                          Colors.orange.shade400,
                          Colors.orange.shade200,
                        ]),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(

                  children: [
                    SizedBox(height: 30,),
                    Text(yazilar[index],style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                    SizedBox(height: 30,),
                    Text(sayilar[index].toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
