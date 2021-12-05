import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class jsondataread with ChangeNotifier {
  List adresil = [];
  List adresilce = ["merhaba"];

  veriyazdirma(BuildContext context) async {
    var jsonoku = await DefaultAssetBundle.of(context).loadString("assets/data/adres.json");
    List adreslist = json.decode(jsonoku.toString());
    List ilcelist;
    for (int i = 0; i < 81; i++) {
      //print(adreslist[i]["il_adi"]);
      ilcelist = adreslist[i]["ilceler"];
      for(int j = 0; j<ilcelist.length;j++){
        print(ilcelist[j]["ilce_adi"]);
        await FirebaseFirestore.instance.collection("il bilgileri").doc(adreslist[i]["il_adi"]).set({ilcelist[j]["ilce_adi"]:"ilçe"},SetOptions(merge: true));
      }
      
      //print(ilcelist[j]["ilce_adi"]);
      //await FirebaseFirestore.instance.collection("iller").doc(adreslist[i]["il_adi"]).set({"ilçe":FieldValue.arrayUnion(ilcelist)},SetOptions(merge: true));
      
    }
  }


}