import 'package:google_maps_flutter/google_maps_flutter.dart';

class MockMarkerService {

  Map<String, Marker> GetShopByLocation(Function onTapFunction) {

      return Map.from({

        "1" : Marker(markerId: MarkerId("1"), position : LatLng(-36.734999,174.70),infoWindow:  InfoWindow(title: 'Cafe Hassle'), onTap: onTapFunction),

        "2" :  Marker(markerId: MarkerId("2"), position : LatLng(-36.734999,174.71680),
        infoWindow:  InfoWindow(title: 'Cafe'), onTap: onTapFunction),

        "3" :  Marker(markerId: MarkerId("3"), position : LatLng(-36.734999,174.712),
        infoWindow:  InfoWindow(title: 'ShopMask'), onTap: onTapFunction
        )

      });
  }
}