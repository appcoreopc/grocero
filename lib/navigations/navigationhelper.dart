import 'package:flutter/material.dart';
import 'package:grocero/Appconstant.dart';
import 'package:grocero/cart/cartpage.dart';
import 'package:grocero/locations/maps/map.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/products/productlistpage.dart';

class NavigationHelper {
  static void NavigateTo<T>(
      BuildContext _context, String routeName, T argumentType) {
    Navigator.pushNamed(
      _context,
      routeName,
      arguments: argumentType,
    );
  }

  Widget CreateNavigationBar(BuildContext context, CartProduct cartProduct) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(Appconstant.exploreMenuText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text(Appconstant.exploreMenuText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text(Appconstant.cartMenuText),
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.amber[800],
      onTap: (idx) => {
        if (idx == 0)
          {
            NavigationHelper.NavigateTo(
                context, MyLocationChooser.routeName, null)
          }
        else if (idx == 1)
          {
            NavigationHelper.NavigateTo(
                context, ProductListingPage.routeName, cartProduct)
          }
        else if (idx == 2)
          {
            NavigationHelper.NavigateTo(
                context, CartPage.routeName, cartProduct)
          }
      },
    );
  }
}
