import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocero/dialogs/locationdialog.dart';
import 'package:geolocator/geolocator.dart';
import 'locations.dart' as locations;

class MyLocationChooser extends StatefulWidget {
  @override
  _MyLocationChooserState createState() => _MyLocationChooserState();
}

class _MyLocationChooserState extends State<MyLocationChooser> {
  final Map<String, Marker> _markers = {};
  bool isLocationConfigured = false;
  double long = 0;
  double lat = 0;

  final navigatorKey = GlobalKey<NavigatorState>();
  LatLng _cameraLongLat = LatLng(0, 0);

  Completer<GoogleMapController> _controller = Completer();

  Future<void> _onMapCreated(GoogleMapController controller) async {

     _controller.complete(controller);

     _setCurrentPosition();
     
    final googleOffices = await locations.getGoogleOffices();

    setState(() {

      _markers.clear();

      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  void _setCurrentPosition() async {

   final GoogleMapController controller = await _controller.future;

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

   final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(position.latitude, position.longitude),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

      controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
   
  }

  @override
  Widget build(BuildContext _context) {

    if (navigatorKey.currentContext != null) {
      var context = navigatorKey.currentState.overlay.context;
      if (!isLocationConfigured) {
        final dialog = LocationDialog('Location', 'Use current location?');
        showDialog(context: context, builder: (x) => dialog);
      }
    }

 return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Set current location'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _cameraLongLat,
                //target: LatLng(0, 0),
                zoom: 2,
              ),
              markers: _markers.values.toSet(),
            ),
          ],
        ),
      ),
    );
  }
}
