import 'package:flutter/material.dart';
import 'package:grocero/components/imagelistview.dart';

class ProductListPage extends StatefulWidget {
  String urlService = "";

  void initState() {}

  ProductListPage(this.urlService);

  @override
  State<StatefulWidget> createState() => ImageListViewState();
}

class ProductListingPage extends StatefulWidget {

  ProductListingPage({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  static const routeName = '/productlisting';
  final String title;
  final String message;
   @override

  State<StatefulWidget> createState() => ImageListViewState();
}
