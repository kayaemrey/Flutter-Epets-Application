import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class addcliniclocation extends StatefulWidget {
  final String adres;
  final String klinikadi;
  final String telno;
  addcliniclocation(this.adres,this.klinikadi,this.telno);
  @override
  State<addcliniclocation> createState() => addcliniclocationState();
}

class addcliniclocationState extends State<addcliniclocation> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.02862627477439, 40.50581639188893),
    zoom: 14,
  );

  static final CameraPosition _kLake = CameraPosition(
      target: LatLng(41.02862627477439, 40.50581639188893),
      zoom: 18);

  Set<Marker> _markers = {};

  firebasedb myDB = new firebasedb();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: GoogleMap(
        markers: _markers,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _handleTap,
      ),
    );
  }

  _handleTap(LatLng point) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'Klinik konumu',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
      print(point.toString());
      myDB.addDataCilinickonum(point.latitude,point.longitude,widget.klinikadi,widget.adres,widget.telno);
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}