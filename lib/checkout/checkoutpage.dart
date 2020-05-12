import 'package:flutter/material.dart';
import 'package:grocero/components/checkoutview.dart';
import 'package:grocero/models/cartproducts.dart';

class CheckoutPage extends StatefulWidget {

  CheckoutPage(this._cartProduct);

  CartProduct _cartProduct;

  static const routeName = '/checkout';


  @override
  State<StatefulWidget> createState() => CheckoutViewState(this._cartProduct);
}
