import 'package:epetsapp/screens/loginstatus.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:epetsapp/services/firebaseStorage.dart';
import 'package:epetsapp/services/jsondataread.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthService()),
        ChangeNotifierProvider(create: (_)=>firebasedb()),
        ChangeNotifierProvider(create: (_)=>jsondataread()),
        ChangeNotifierProvider(create: (_)=>firebasestorage()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Pets',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return loginstatus();
  }
}