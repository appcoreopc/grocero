import 'package:flutter/material.dart';
import 'package:grocero/Appconstant.dart';
import 'package:grocero/cart/cartpage.dart';
import 'package:grocero/cart/notificationRenderType.dart';
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
          icon: createNotification(
              "Home", Icons.home, NotificationRenderType.none),
          title: Text(Appconstant.exploreMenuText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text(Appconstant.exploreMenuText),
        ),
        BottomNavigationBarItem(
          icon: createNotification(
              Appconstant.cartMenuText, Icons.home, cartProduct.notificationRenderType),
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

  Widget createNotification(String textToRender, IconData iconToRender,
      NotificationRenderType notificationRenderType) {
    switch (notificationRenderType) {
      case NotificationRenderType.simpleDot:
        return Stack(children: <Widget>[
          Icon(iconToRender),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Icon(Icons.brightness_1, size: 8.0, color: Colors.redAccent),
          )
        ]);

      case NotificationRenderType.textDecoration:
        return Stack(
          children: <Widget>[
            Icon(iconToRender),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                child: Text(
                  textToRender,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        );
      case NotificationRenderType.none:
      default:
        return Icon(iconToRender);
    }
  }
}