import 'package:flutter/material.dart';
import 'package:grocero/components/productlistviewstate.dart';

class ProductListingPage extends StatefulWidget {

  // ProductListingPage({
  //   Key key,
  //   @required this.title,
  //   @required this.message,
  // }) : super(key: key);

  static const routeName = '/explore';
  String title;
  String message;
   @override

  State<StatefulWidget> createState() => ProductListViewState();
}
