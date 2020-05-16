import 'package:flutter/material.dart';
import 'package:grocero/Appconstant.dart';
import 'package:grocero/cart/cartpage.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/home/homepage.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/products/productlistpage.dart';

class NavigationHelper {
  //////////////////////////////////
  // Navigate to other screens
  //////////////////////////////////
  static void NavigateTo<T>(
      BuildContext _context, String routeName, T argumentType) {
    Navigator.pushNamed(
      _context,
      routeName,
      arguments: argumentType,
    );
  }

  //////////////////////////////////
  ///
  /// Creates NavigationBar button
  ///
  //////////////////////////////////

  Widget CreateNavigationBar(BuildContext context, CartProduct cartProduct) {
    Color homeColor = Appconstant.allGreyColor;
    Color exploreColor = Appconstant.allGreyColor;
    Color cartColor = Appconstant.allGreyColor;

    if (cartProduct.navigationBarPageIndex == 0) {
      homeColor = Appconstant.greenColor;
    }

    if (cartProduct.navigationBarPageIndex == 1) {
      exploreColor = Appconstant.greenColor;
    }

    if (cartProduct.navigationBarPageIndex == 2) {
      cartColor = Appconstant.greenColor;
    }

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: createNotification(Appconstant.homeMenuText, Icons.home,
              NotificationRenderType.none, homeColor),
          title: Text(Appconstant.homeMenuText),
        ),
        BottomNavigationBarItem(
          icon: createNotification(Appconstant.exploreMenuText, Icons.search,
              NotificationRenderType.none, exploreColor),
          title: Text(Appconstant.exploreMenuText),
        ),
        BottomNavigationBarItem(
          icon: createNotification(
              Appconstant.cartMenuText,
              Icons.shopping_cart,
              cartProduct.notificationRenderType,
              cartColor),
          title: Text(Appconstant.cartMenuText),
        ),
      ],
      currentIndex: cartProduct.navigationBarPageIndex,
      selectedItemColor: Appconstant.greenColor,
      onTap: (idx) => {
        if (idx == 0)
          {NavigationHelper.NavigateTo(context, HomePage.routeName, null)}
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

  ///////////////////////////////
  /// Create navigation at the bottomm
  ///  icons and text
  ///////////////////////////////

  Widget createNotification(String textToRender, IconData iconToRender,
      NotificationRenderType notificationRenderType, Color targetColor) {
    switch (notificationRenderType) {
      case NotificationRenderType.simpleDot:
        return Stack(children: <Widget>[
          Icon(iconToRender),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: Icon(Icons.brightness_1, size: 8.0, color: Colors.red),
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
                    color: Appconstant.allGreyColor,
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
        return Icon(iconToRender, color: targetColor);
    }
  }
}
