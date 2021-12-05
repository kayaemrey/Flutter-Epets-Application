import 'package:epetsapp/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

AuthService auth = new AuthService();

class firebasestorage with ChangeNotifier {
  File _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    await firebase_storage.FirebaseStorage.instance
        .ref('profile/${auth.authid()}.png')
        .putFile(_image);
    debugPrint("add image");
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('profile/${auth.authid()}.png')
        .getDownloadURL();
    debugPrint(downloadURL);
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).set({"profilepic": downloadURL},SetOptions(merge: true)).then((value) => debugPrint("add users picture data"));
  }
  Future<void> getImagePet(String doc,String picname) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    await firebase_storage.FirebaseStorage.instance
        .ref('petsprofile/"$picname".png')
        .putFile(_image);
    debugPrint("add image");
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('petsprofile/"$picname".png')
        .getDownloadURL();
    debugPrint(downloadURL);
    await FirebaseFirestore.instance.collection("users").doc(auth.authid()).collection("hayvanlar").doc(doc).set({"picture": downloadURL},SetOptions(merge: true)).then((value) => debugPrint("add users picture data"));
  }
  Future<void> getImageEmerGal(String picname,String konu,String name,String aciklama) async {
    Map<String, dynamic> emergencydata = Map();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    await firebase_storage.FirebaseStorage.instance
        .ref('emergency/"$picname".png')
        .putFile(_image);
    debugPrint("add image");
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('emergency/"$picname".png')
        .getDownloadURL();
    debugPrint(downloadURL);
    emergencydata["picture"] = downloadURL;
    emergencydata["konu"] = konu;
    emergencydata["name"] = name;
    emergencydata["aciklama"] = aciklama;
    await FirebaseFirestore.instance.collection("emergency").doc().set(emergencydata,SetOptions(merge: true)).then((value) => debugPrint("add users picture data"));
  }
  Future<void> getImageEmerCam(String picname,String konu,String name,String aciklama) async {
    Map<String, dynamic> emergencydata = Map();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _image = File(pickedFile.path);
    await firebase_storage.FirebaseStorage.instance
        .ref('emergency/"$picname".png')
        .putFile(_image);
    debugPrint("add image");
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('emergency/"$picname".png')
        .getDownloadURL();
    debugPrint(downloadURL);
    emergencydata["picture"] = downloadURL;
    emergencydata["konu"] = konu;
    emergencydata["name"] = name;
    emergencydata["aciklama"] = aciklama;
    await FirebaseFirestore.instance.collection("emergency").doc().set(emergencydata,SetOptions(merge: true)).then((value) => debugPrint("add users picture data"));
  }

}