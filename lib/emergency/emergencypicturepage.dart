import 'package:epetsapp/screens/loginpage.dart';
import 'package:epetsapp/services/firebaseStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class emergencypicturepage extends StatefulWidget {
  final String name;
  final String konu;
  final String aciklama;
  emergencypicturepage(this.name,this.konu,this.aciklama);
  @override
  _emergencypicturepageState createState() => _emergencypicturepageState();
}

class _emergencypicturepageState extends State<emergencypicturepage> {
  @override
  Widget build(BuildContext context) {
    final myStorage = Provider.of<firebasestorage>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: InkWell(
                    child: Image.asset("assets/images/imagepicture.png",width: 256,height: 256,),
                  onTap: (){
                    AlertDialog alert = AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                      ),
                      backgroundColor: Colors.blue.shade400,
                      title: Text("Yüklemek istediğiniz resim yolunu seçiniz"),
                      actions: [
                        TextButton(child: Text("Camera",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
                          myStorage.getImageEmerCam(widget.name + "-" + widget.konu,widget.konu,widget.name,widget.aciklama);
                        }),
                        TextButton(child: Text("Galeri",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
                          myStorage.getImageEmerGal(widget.name + "-" + widget.konu,widget.konu,widget.name,widget.aciklama);
                        }),
                        TextButton(child: Text("Çık",style: TextStyle(color: Colors.black,fontSize: 18),), onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
                        }),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}
