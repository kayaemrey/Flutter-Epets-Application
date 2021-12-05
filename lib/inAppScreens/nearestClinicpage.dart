import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epetsapp/services/authService.dart';
import 'package:epetsapp/services/firebaseDB.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  Set<Marker> _markers = {};
  Future<void> konumgetirici() async {
    await FirebaseFirestore.instance
        .collection('klinikadres')
        .get()
        .then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId(doc["klinik"]["klinikadi"]),
          position: LatLng(doc["klinik"]["latitude"],
              doc["klinik"]["longitude"]),
          infoWindow: InfoWindow(
            title: doc["klinik"]["klinikadi"],
            snippet: doc["klinik"]["adres"],
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue),
        ));
      });
    })
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  Location _location = Location();

  static final CameraPosition _kGooglePlex = CameraPosition(target: LatLng(41.02862627477439, 40.50581639188893), zoom: 15,);


  @override
  void initState() {
    // TODO: implement initState
    konumgetirici();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    final myDB = Provider.of<firebasedb>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('klinikadres');


    return Scaffold(
      appBar: AppBar(
        title: const Text("E-pets"),
      ),
      body: _markers != null ? GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ) : Center(child: CircularProgressIndicator(),),
      floatingActionButton: Container(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton.extended(
              onPressed: _goToTheLake,
              label: Text('Konum'),
              icon: Icon(Icons.my_location),
            ),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    _location.onLocationChanged.listen((l) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
        ),
      );
    });
  }
}