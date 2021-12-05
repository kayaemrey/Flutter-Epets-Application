import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

AuthService auth = new AuthService();

class firebasedb with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void adduser(String name,String tip) async{
    Map<String, dynamic> users = Map();
    users["email"] = _auth.currentUser.email;
    users["name"] = name;
    users["tip"] = tip;
    users["id"] = auth.authid();
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).set(users,SetOptions(merge: true)).then((value) => debugPrint("add user data"));
  }
  void adduserinfo (String name,String kullaniciadi,String telno,String tcno) async{
    Map<String, dynamic> users = Map();
    users["name"] = name;
    users["kullaniciadi"] = name;
    users["telefonno"] = telno;
    users["tcno"] = tcno;

    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).set(users,SetOptions(merge: true)).then((value) => debugPrint("add user data"));
  }
  void addData(String data,String eklenecek)async{
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).set({eklenecek:data},SetOptions(merge: true));
  }

  void addpetsData(String eklenecek,String data)async{
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).collection("pets").doc("petsnames").set({eklenecek:data},SetOptions(merge: true));
    print("add pets name $data");
  }
  void addDataCol(String klinikadi,String unvan,String telno,String vergino,String webpage,String aciklama,String acikadres)async{
    Map<String, dynamic> usersclinic = Map();
    usersclinic["klinikadi"] = klinikadi;
    usersclinic["unvan"] = unvan;
    usersclinic["telno"] = telno;
    usersclinic["vergino"] = vergino;
    usersclinic["webpage"] = webpage;
    usersclinic["aciklama"] = aciklama;
    usersclinic["il"] = "";
    usersclinic["ilce"] = "";
    usersclinic["açıkadres"] = acikadres;

    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).set({"klinik": usersclinic},SetOptions(merge: true));
    print("add data clinic");
  }
  void addDataCilinicil(String il)async{
    Map<String, dynamic> usersclinic = Map();
    usersclinic["il"] = il;
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).set({"klinik" :usersclinic },SetOptions(merge: true));
  }
  void addDataCilinicilce(String ilce)async{
    Map<String, dynamic> usersclinic = Map();
    usersclinic["ilce"] = ilce;
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).set({"klinik" :usersclinic },SetOptions(merge: true));
  }
  void addDataCilinickonum(double latitude,double longitude,String klinikadi,String adres,String telno)async{
    Map<String, dynamic> usersclinic = Map();
    usersclinic["latitude"] = latitude;
    usersclinic["longitude"] = longitude;
    usersclinic["klinikadi"] = klinikadi;
    usersclinic["adres"] = adres;
    usersclinic["telno"] = telno;
    await FirebaseFirestore.instance.collection("klinikadres").doc(auth.authid()).set({"klinik" :usersclinic },SetOptions(merge: true));
  }
  Future<void> deleteFieldvet(String silinecek,String colec,String docid) {
    return FirebaseFirestore.instance
    .collection("users")
        .doc(auth.authid()).collection(colec).doc()
        .update({silinecek: FieldValue.delete()})
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> deletevetinfo(String colec,String docid) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(auth.authid()).collection(colec).doc(docid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
  Future<String> sorgulama(String collec,String docid,String sorgulanacak)async{
    await FirebaseFirestore.instance
        .collection(collec)
        .doc(docid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data()[sorgulanacak]);
        return documentSnapshot.data()[sorgulanacak];
      }
    });
  }
  void addpetuser(String name,String mikrocipno,String passportno,String tur,String irk,String cinsiyet,String dtarihi)async{
    Map<String, dynamic> petdata = Map();
    petdata["name"] = name;
    petdata["mikrocipno"] = mikrocipno;
    petdata["passportno"] = passportno;
    petdata["tur"] = tur;
    petdata["irk"] = irk;
    petdata["cinsiyet"] = cinsiyet;
    petdata["dtarihi"] = dtarihi;
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).collection("hayvanlar").doc().set(petdata,SetOptions(merge: true));
    print("add data pet");
  }
  void addpethayvanlar(String collec,String name,String mikrocipno,String passportno,String tur,String irk,String cinsiyet,String dtarihi)async{
    Map<String, dynamic> petdata = Map();
    petdata["name"] = name;
    petdata["mikrocipno"] = mikrocipno;
    petdata["passportno"] = passportno;
    petdata["tur"] = tur;
    petdata["irk"] = irk;
    petdata["cinsiyet"] = cinsiyet;
    petdata["dtarihi"] = dtarihi;
    await FirebaseFirestore.instance.collection(collec).doc(auth.authid()).set({name:petdata},SetOptions(merge: true));
    print("add data pet");
  }
  void addAgenda(String baslik,String aciklama,String tarih)async{
    Map<String, dynamic> agenda = Map();
    agenda["başlık"] = baslik;
    agenda["açıklama"] = aciklama;
    agenda["tarih"] = tarih;
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).collection("veterinarynots").doc().set(agenda,SetOptions(merge: true));
  }
  void addappovet(String musname,String hasname,String mikrocipno,String passportno,String tur,
      String irk,String cinsiyet,String dtarihi,String kayitt,String not)async{
    Map<String, dynamic> petdataappo = Map();
    petdataappo["müşteriname"] = musname;
    petdataappo["hastaname"] = hasname;
    petdataappo["mikroçipno"] = mikrocipno;
    petdataappo["passportno"] = passportno;
    petdataappo["tür"] = tur;
    petdataappo["irk"] = irk;
    petdataappo["cinsiyet"] = cinsiyet;
    petdataappo["dogumtarihi"] = dtarihi;
    petdataappo["kayittarihi"] = kayitt;
    petdataappo["not"] = not;
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).collection("veterinarappointment").doc().set(petdataappo,SetOptions(merge: true));
    print("add data pet");
  }
  void addcustomer(String customerid,String name,String vetid)async{
    Map<String, dynamic> agenda = Map();
    agenda["veteriner"] = name;
    agenda["id"] = vetid;
    await FirebaseFirestore.instance.collection("users").doc(customerid).collection("veterinars").doc(auth.authid()).set(agenda,SetOptions(merge: true));
  }
  void addcustomerpet(String id,String customerid,String kullaniciadi,String name)async{
    Map<String, dynamic> agenda = Map();
    agenda["customerid"] = customerid;
    agenda["kullaniciadi"] = kullaniciadi;
    agenda["name"] = name;
    await FirebaseFirestore.instance.collection("users").doc(id).collection("veterinarcustomer").doc(auth.authid()).set(agenda,SetOptions(merge: true));
  }

  Future<void> deleteveruserpet(String docid) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(auth.authid()).collection("veterinars").doc(docid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
  
  void addPetsAsi(String authid,String petid,String asi,String kayit,)async{
    Map<String, dynamic> petdata = Map();
    petdata["asi_adi"] = asi;
    petdata["kayitzamani"] = kayit;
    List asilar = [];
    asilar.add(petdata);
    await FirebaseFirestore.instance.collection("users").doc(authid).collection("hayvanlar").doc(petid).set({"asilar":FieldValue.arrayUnion(asilar)},SetOptions(merge: true));
    print("add data pet");
  }

}
