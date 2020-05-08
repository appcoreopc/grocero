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

  final navigatorKey = GlobalKey<NavigatorState>();
  double long = 0; 
  double lat = 0;
  var cameraLongLat = LatLng(0, 0);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {

      cameraLongLat = LatLng(position.longitude, position.longitude);
      
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

  @override
  Widget build(BuildContext _context) {

    final context = navigatorKey.currentState.overlay.context;

    if (!isLocationConfigured) 
    {
        final dialog = LocationDialog('Location', 'Use current location?');
        showDialog(context: context, builder: (x) => dialog);
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
                  target: cameraLongLat,
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
