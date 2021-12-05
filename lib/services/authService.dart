import 'package:epetsapp/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum userstatus {
  oturumacilmis,
  oturumacilmamis,
  oturumaciliyor,
}

class AuthService with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  userstatus _status = userstatus.oturumacilmamis;

  userstatus get status => _status;

  set status(userstatus value) {
    _status = value;
    notifyListeners();
  }

  AuthService() {
    _auth.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(User user) {
    if (user == null) {
      status = userstatus.oturumacilmamis;
    } else {
      status = userstatus.oturumacilmis;
    }
  }

  String authid(){
    final User user = FirebaseAuth.instance.currentUser;
    final String uid = user.uid;
    return uid;
  }

  Future<User> createuser(String email, String password) async {
    status = userstatus.oturumaciliyor;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      if (!userCredential.user.emailVerified) {
        await userCredential.user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User> signinuser(String email, String password) async {
    try {
      status = userstatus.oturumaciliyor;
      UserCredential _credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User signinuser = _credential.user;
      return signinuser;
    } catch (e) {
      status = userstatus.oturumacilmamis;
      print("signin user error $e");
      return null;
    }
  }

  Future<bool> signout() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print("$e");
      return false;
    }
  }

  void signinstatus(BuildContext context) async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          print('User is currently signed out!');
        } else if (_auth.currentUser.emailVerified == false) {
          print('User not email verified!');
        } else {
          print('User is signed in!');
          Navigator.push(context, MaterialPageRoute(builder: (context) => homepage()));
        }
      });
    } catch (e) {
      print("$e");
    }
  }
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
