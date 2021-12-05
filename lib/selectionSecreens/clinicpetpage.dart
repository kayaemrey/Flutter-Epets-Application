import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class clinipetcpage extends StatefulWidget {
  @override
  _clinipetcpageState createState() => _clinipetcpageState();
}

class _clinipetcpageState extends State<clinipetcpage> {
  String tik = "1";
  List imagesnamelist = [
    "assets/petsimages/cat.png",
    "assets/petsimages/dog.png",
    "assets/petsimages/fish.png",
    "assets/petsimages/hamster.png",
    "assets/petsimages/rabbit.png",
    "assets/petsimages/bird.png",
  ];
  List petsname = [
    "Cat",
    "Dog",
    "Fish",
    "Hamster",
    "Rabbit",
    "Bird",
  ];
  List tiktik =[0,0,0,0,0,0];
  @override
  Widget build(BuildContext context) {
    final myDB = Provider.of<firebasedb>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: ListView.builder(
        itemCount: imagesnamelist.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      imagesnamelist[index],
                      fit: BoxFit.cover,
                      width: 64,
                      height: 64,
                    ),
                    Text(petsname[index],style: TextStyle(fontSize: 24),),
                    tiktik[index] == "1" ? IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.circle,color: Colors.grey.shade700,),
                      onPressed: (){
                        myDB.addpetsData(petsname[index], "pet");
                        setState(() {
                          tiktik[index] = "2";
                        });
                      },
                    ) : IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.check_circle_outline,color: Colors.blue,),
                      onPressed: (){
                        setState(() {
                          tiktik[index] = "1";
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
