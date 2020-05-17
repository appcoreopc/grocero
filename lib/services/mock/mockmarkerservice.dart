import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocero/models/productcategory.dart';
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
        "Beans imported from South America with a twist. This is something that keeps you going all day",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/latte.jpg",
        "http://weburl", 5.00));

    targetList.add(ProductListingModel(
        "HasteCafe",
        "Americano",
        "HasteCafe special Americano",
        "Beans imported from South America, best of it's class and keeps you craving for more and more.",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/latte.jpg",
        "http://weburl", 5.00));

    targetList.add(ProductListingModel(
        "HasteCafe",
        "Long Black",
        "HasteCafe special Long Black",
        "Beans imported from South America. Roasted to perfection and gives extra aromatic kick.",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/Vanilla-Chai.jpg",
        "http://weburl.", 4.50));

    targetList.add(ProductListingModel(
        "HasteCafe",
        "Cappucino",
        "HasteCafe special Long Black",
        "Beans imported from South America. The best blend that you can ever get from here.",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/flat-white.jpg",
        "http://weburl.", 4.50));

    targetList.add(ProductListingModel(
        "HasteCafe",
        "Long White",
        "HasteCafe special Long Black",
        "Beans imported from South America, ultimate drinking pleasure",
        "https://elisabeth.co.nz/wp-content/uploads/2020/04/flat-white.jpg",
        "http://weburl.", 3.0));

    return Future.value(targetList);
  }

  static Future<List<ProductCategory>> getProductCategories() {

    var list = List<ProductCategory>();
    list.add(ProductCategory("bakery", "bakery", "fresh from the oven", "https://elisabeth.co.nz/wp-content/uploads/2020/04/flat-white.jpg"));
    list.add(ProductCategory("vege", "vege", "fresh farm", "https://elisabeth.co.nz/wp-content/uploads/2020/04/flat-white.jpg"));
    list.add(ProductCategory("meat", "meat", "fresh always", "https://elisabeth.co.nz/wp-content/uploads/2020/04/flat-white.jpg"));
    list.add(ProductCategory("drinks", "drinks", "", "https://elisabeth.co.nz/wp-content/uploads/2020/04/flat-white.jpg"));
    return Future.value(list); 
  }
}
