

import 'package:flutter/material.dart';
import 'package:grocero/models/productargument.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/productdetails';
  final String title;
  final String message;

  const ProductDetailPage({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ProductArgument args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

