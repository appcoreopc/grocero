import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocero/cart/cartpage.dart';
import 'package:grocero/checkout/checkoutpage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productargument.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/payment/makepayment.dart';
import 'package:grocero/products/productlistpage.dart';

class MyLocationPage extends StatefulWidget {
  static String routeName = "/myLocationChooser";

  @override
  _MyLocationPageState createState() => _MyLocationPageState();
}

class _MyLocationPageState extends State<MyLocationPage> {
  Map<String, Marker> _markers = {};
  final navigatorKey = GlobalKey<NavigatorState>();
  LatLng _cameraLongLat = LatLng(0, 0);
  Completer<GoogleMapController> _controller = Completer();

  bool isLocationConfigured = false;
  double long = 0;
  double lat = 0;

  void _viewShopListing(String markerId) {
    if (navigatorKey.currentContext != null) {
      var _mapcontext = navigatorKey.currentState.overlay.context;

      NavigationHelper.NavigateTo(
          _mapcontext,
          ProductListingPage.routeName,
          ProductArgument(
            markerId,
            'This message is extracted in the onGenerateRoute function.',
          ));
    }
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    _setCameraToCurrentPosition();
    final shopMarkers = _GetShopByLocation();

    setState(() {
      _markers.clear();
      _markers = shopMarkers;
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
  
    // if (navigatorKey.currentContext != null) {
    //   var context = navigatorKey.currentState.overlay.context;
    //   if (!isLocationConfigured) {
    //     final locationDialog =
    //         LocationDialog('Configure Location', 'Use current location?');
    //     showDialog(context: context, builder: (x) => locationDialog);
    //   }
    // }

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
          bottomNavigationBar:
              NavigationHelper().
              CreateNavigationBar(this.context, null)
        ),
        onGenerateRoute: (settings) {
          if (settings.name == MyLocationPage.routeName) {
            return MaterialPageRoute(
                builder: (BuildContext context) => MyLocationPage(),
                maintainState: true,
                fullscreenDialog: false);
          } else if (settings.name == ProductListingPage.routeName) {
            return MaterialPageRoute(
              builder: (BuildContext context) => ProductListingPage(),
              maintainState: true,
              fullscreenDialog: false,
            );
          } else if (settings.name == CartPage.routeName) {
            var cartData = settings.arguments as CartProduct;
            return MaterialPageRoute(
              builder: (BuildContext context) => CartPage(cartData),
              maintainState: true,
              fullscreenDialog: false,
            );
          } else if (settings.name == CheckoutPage.routeName) {
            var cartData = settings.arguments as CartProduct;
            return MaterialPageRoute(
              builder: (BuildContext context) => CheckoutPage(cartData),
              maintainState: true,
              fullscreenDialog: false,
            );
          } else if (settings.name == MakePaymentPage.routeName) {
            var cartData = settings.arguments as CartProduct;
            return MaterialPageRoute(
              builder: (BuildContext context) => MakePaymentPage(cartData),
              maintainState: true,
              fullscreenDialog: false,
            );
          } 
          
           else {
            return null;
          }
        });
  }

  Map<String, Marker> _GetShopByLocation() {
    return Map.from({
      "1": Marker(
          markerId: MarkerId("1"),
          position: LatLng(-36.734999, 174.70),
          infoWindow: InfoWindow(title: 'Cafe Hassle'),
          onTap: () => _viewShopListing("1")),
      "2": Marker(
          markerId: MarkerId("2"),
          position: LatLng(-36.734999, 174.71680),
          infoWindow: InfoWindow(title: 'Cafe'),
          onTap: () => _viewShopListing("2")),
      "3": Marker(
          markerId: MarkerId("3"),
          position: LatLng(-36.734999, 174.712),
          infoWindow: InfoWindow(title: 'ShopMask'),
          onTap: () => _viewShopListing("3"))
    });
  }
}
