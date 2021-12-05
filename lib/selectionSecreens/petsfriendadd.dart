import 'package:epetsapp/selectionSecreens/petsDBaddpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class petsfriendpage extends StatefulWidget {
  @override
  _petsfriendpageState createState() => _petsfriendpageState();
}

class _petsfriendpageState extends State<petsfriendpage> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: ListView.builder(
        itemCount: imagesnamelist.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>petsdbaddpage(petsname[index])));
            },
            title: Padding(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      imagesnamelist[index],
                      fit: BoxFit.cover,
                      width: 64,
                      height: 64,
                    ),
                    Text(petsname[index],style: TextStyle(fontSize: 24),),
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
