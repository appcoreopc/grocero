import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocero/models/productlistingmodel.dart';

class MockDataService {

  Map<String, Marker> GetShopByLocation(Function onTapFunction) {
    return Map.from({
      "1": Marker(
          markerId: MarkerId("1"),
          position: LatLng(-36.734999, 174.70),
          infoWindow: InfoWindow(title: 'Cafe Hassle'),
          onTap: onTapFunction),
      "2": Marker(
          markerId: MarkerId("2"),
          position: LatLng(-36.734999, 174.71680),
          infoWindow: InfoWindow(title: 'Cafe'),
          onTap: onTapFunction),
      "3": Marker(
          markerId: MarkerId("3"),
          position: LatLng(-36.734999, 174.712),
          infoWindow: InfoWindow(title: 'ShopMask'),
          onTap: onTapFunction)
    });
  }

  static Future<List<ProductListingModel>> GetProductListing() {
    var targetList = List<ProductListingModel>();

    targetList.add(ProductListingModel(
        "HasteCafe",
        "Latte",
        "HasteCafe special Latte",
        "Beans imported from South America",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/latte.jpg",
        "http://weburl"));

    targetList.add(ProductListingModel(
        "HasteCafe",
        "Americano",
        "HasteCafe special Americano",
        "Beans imported from South America",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/latte.jpg",
        "http://weburl"));

    targetList.add(ProductListingModel(
        "HasteCafe",
        "Long Black",
        "HasteCafe special Long Black",
        "Beans imported from South America",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/Vanilla-Chai.jpg",
        "http://weburl."));

    targetList.add(ProductListingModel(
        "HasteCafe",
        "Cappucino",
        "HasteCafe special Long Black",
        "Beans imported from South America",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/CAPPUCCINO.jpg",
        "http://weburl."));

    targetList.add(ProductListingModel(
        "HasteCafe",
        "Long White",
        "HasteCafe special Long Black",
        "Beans imported from South America",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/flat-white.jpg",
        "http://weburl."));

      

    return Future.value(targetList);
  }
}