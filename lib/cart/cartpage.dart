import 'package:flutter/material.dart';
import 'package:grocero/components/cartlistview.dart';

class CartPage extends StatefulWidget {

  // CheckoutPage({
  //   Key key,
  //   @required this.title,
  //   @required this.message,
  // }) : super(key: key);

  static const routeName = '/cart';
  String title;
  String message;
   @override

  State<StatefulWidget> createState() => CartListViewState();
}
