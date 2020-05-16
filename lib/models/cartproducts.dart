import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/models/productlistingmodel.dart';

class CartProduct {
  CartProduct(this.productCount, this.productListings, this.notificationRenderType);

  List<ProductListingModel> productListings;

  // uses string id to map to product listing models
  Map<String, int> productCount = Map<String, int>();

  NotificationRenderType notificationRenderType;

  // for setting up navigationbar 
  int navigationBarPageIndex = 0;

}
