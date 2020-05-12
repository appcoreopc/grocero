import 'package:flutter/material.dart';
import 'package:grocero/components/cartlistview.dart';
import 'package:grocero/models/cartproducts.dart';

class CartPage extends StatefulWidget {
  
  CartPage(this._cartProduct);
  
  CartProduct _cartProduct;

  static const routeName = '/cart';
  String title;
  String message;
   @override

  State<StatefulWidget> createState() => CartListViewState(_cartProduct);
}
