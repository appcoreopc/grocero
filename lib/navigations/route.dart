import 'package:flutter/material.dart';
import 'package:grocero/cart/cartpage.dart';
import 'package:grocero/checkout/checkoutpage.dart';
import 'package:grocero/home/homepage.dart';
import 'package:grocero/locations/maps/mylocatiopage.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/payment/makepayment.dart';
import 'package:grocero/products/productlistpage.dart';

class AppRoutes {
  static Route<dynamic> setupRoutes(RouteSettings settings) {
    if (settings.name == HomePage.routeName) {
      return MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
          maintainState: true,
          fullscreenDialog: false);
    } else if (settings.name == MyLocationPage.routeName) {
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
      return MaterialPageRoute(
        builder: (BuildContext context) => MakePaymentPage(),
        maintainState: true,
        fullscreenDialog: false,
      );
    } else {
      return null;
    }
  }
}
