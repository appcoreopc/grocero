import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocero/dialogs/locationdialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocero/services/mockmarkerservice.dart';

class MyLocationChooser extends StatefulWidget {
  @override
  _MyLocationChooserState createState() => _MyLocationChooserState();
}

class _MyLocationChooserState extends State<MyLocationChooser> {
  Map<String, Marker> _markers = {};
  final navigatorKey = GlobalKey<NavigatorState>();
  LatLng _cameraLongLat = LatLng(0, 0);
  Completer<GoogleMapController> _controller = Completer();


  bool isLocationConfigured = false;
  double long = 0;
  double lat = 0;

  void _browseShopListing(String markerId) {
    //Navigator.of(context).push()
    print("Getting ontap event" + markerId);

  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
  
    _setCameraToCurrentPosition();

    // final shopMarkers =
    //     MockMarkerService().GetShopByLocation(_browseShopListing);

    final shopMarkers = GetShopByLocation();

    setState(() {
      _markers.clear();
      _markers = shopMarkers;

      // for (final office in shopMarkers) {
      //   final marker = Marker(
      //     markerId: MarkerId(office.markerId),
      //     position: LatLng(office.lat, office.lng),
      //     infoWindow: InfoWindow(
      //       title: office.name,
      //       snippet: office.address,
      //     ),
      //   );
      //   _markers[office.name] = marker;
      // }
    });
  }

  void _setCameraToCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final CameraPosition _currentlocationPoint = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(position.latitude, position.longitude),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_currentlocationPoint));
  }

  @override
  Widget build(BuildContext _context) {
    if (navigatorKey.currentContext != null) {
      var context = navigatorKey.currentState.overlay.context;
      if (!isLocationConfigured) {
        final locationDialog =
            LocationDialog('Location', 'Use current location?');
        showDialog(context: context, builder: (x) => locationDialog);
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
                zoom: 2,
              ),
              markers: _markers.values.toSet(),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, Marker> GetShopByLocation() {

      return Map.from({

        "1" : Marker(markerId: MarkerId("1"), position : LatLng(-36.734999,174.70),infoWindow:  InfoWindow(title: 'Cafe Hassle'), onTap: () => _browseShopListing("1")),

        "2" :  Marker(markerId: MarkerId("2"), position : LatLng(-36.734999,174.71680),
        infoWindow:  InfoWindow(title: 'Cafe'), onTap: () => _browseShopListing("2")),

        "3" :  Marker(markerId: MarkerId("3"), position : LatLng(-36.734999,174.712),
        infoWindow:  InfoWindow(title: 'ShopMask'), onTap: () => _browseShopListing("3")
        )

      });
  }
}
