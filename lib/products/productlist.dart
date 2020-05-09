import 'package:flutter/material.dart';
import 'package:grocero/components/imagelistview.dart';

class ProductList extends StatefulWidget {
  String urlService = "";

  void initState() {}

  ProductList(this.urlService);

  @override
  State<StatefulWidget> createState() => ImageListViewState();
}


class ProductListingPage extends StatelessWidget {
  static const routeName = '/productlisting';

  final String title;
  final String message;

  // This Widget accepts the arguments as constructor parameters. It does not
  // extract the arguments from the ModalRoute.
  //
  // The arguments are extracted by the onGenerateRoute function provided to the
  // MaterialApp widget.
  const ProductListingPage({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
