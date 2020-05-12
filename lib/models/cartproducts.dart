import 'package:grocero/models/productlistingmodel.dart';

class CartProduct {
  CartProduct(this.productCount, this.productListings);

  List<ProductListingModel> productListings;

  // uses string id to map to product listing models
  Map<String, int> productCount = Map<String, int>();
}
