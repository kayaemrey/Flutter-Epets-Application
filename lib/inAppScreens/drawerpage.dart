import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/inAppScreens/clinicpage.dart';
import 'package:epetsapp/inAppScreens/faqpage.dart';
import 'package:epetsapp/inAppScreens/friends.dart';
import 'package:epetsapp/inAppScreens/nearestClinicpage.dart';
import 'package:epetsapp/inAppScreens/profilepage.dart';
import 'package:epetsapp/inAppScreens/settingspage.dart';
import 'package:epetsapp/screens/homepage.dart';
import 'package:epetsapp/selectionSecreens/petsfriendadd.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class drawerpage extends StatefulWidget {
  @override
  _drawerpageState createState() => _drawerpageState();
}

class _drawerpageState extends State<drawerpage> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(myAuth.authid()).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Container(
            child: data["tip"] == "1"
                ? Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  maxRadius: 40,
                                  backgroundImage: data["profilepic"] == null
                                      ? AssetImage("assets/petsimages/cat.png")
                                      : NetworkImage(data["profilepic"]),
                                ),
                                Text(
                                  data["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )),
                        ListTile(
                          leading: Icon(Icons.group),
                          title: Text('Home page'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homepage()));
                          },
                        ),
                        ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text('Profile'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => profilepage()));
                            }),
                        ListTile(
                            leading: Icon(Icons.pets),
                            title: Text('Dostlarım'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => friendspage()));
                            }),
                        ListTile(
                          leading: Icon(Icons.map),
                          title: Text("En yakın klinik"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapSample()));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.list_alt),
                          title: Text('Sıkça sorulan sorular'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => faqpage()));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => settingspage()));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.lock),
                          title: Text('Çıkış yap'),
                          onTap: () {
                            myAuth.signout();
                          },
                        ),
                      ],
                    ),
                  )
                : Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  maxRadius: 42,
                                  backgroundImage: data["profilepic"] == null
                                      ? AssetImage("assets/petsimages/cat.png")
                                      : NetworkImage(data["profilepic"]),
                                ),
                                Text(
                                  data["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )),
                        ListTile(
                          leading: Icon(Icons.group),
                          title: Text('Home page'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homepage()));
                          },
                        ),
                        ListTile(
                            leading: Icon(Icons.account_circle),
                            title: Text('Profile'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => profilepage()));
                            }),
                        ListTile(
                          leading: Icon(Icons.text_snippet),
                          title: Text("Klinik"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => clinicpage()));
                          },
                        ),
                        ListTile(
                            leading: Icon(Icons.pets),
                            title: Text('Dostlarım'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => friendspage()));
                            }),
                        ListTile(
                          leading: Icon(Icons.map),
                          title: Text("En yakın klinik"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapSample()));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.list_alt),
                          title: Text('Sıkça sorulan sorular'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => faqpage()));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => settingspage()));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.lock),
                          title: Text('Çıkış yap'),
                          onTap: () {
                            myAuth.signout();
                          },
                        ),
                      ],
                    ),
                  ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
