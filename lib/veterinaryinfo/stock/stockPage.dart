import 'package:flutter/material.dart';

class stockvetpage extends StatefulWidget {
  @override
  _stockvetpageState createState() => _stockvetpageState();
}

class _stockvetpageState extends State<stockvetpage> {
  TextEditingController txtstockname = TextEditingController();
  TextEditingController txtnumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("data")
          ],
        ),
      ),
    );
  }
}
