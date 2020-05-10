import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/services/mock/mockmarkerservice.dart';
import 'package:grocero/style/appstyle.dart';

class ImageListViewState<T extends StatefulWidget> extends State<T> {
  Future<List<ProductListingModel>> _futureDataSource;
  Map<String, int> productCount = Map<String, int>();

  @override
  void initState() {
    super.initState();
    _futureDataSource = MockDataService.GetProductListing();
  }

  @override
  Widget build(BuildContext context) {
    _futureDataSource = MockDataService.GetProductListing();

    return Scaffold(
        body: FutureBuilder<List<ProductListingModel>>(
          future: _futureDataSource,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildProductListingData(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
        backgroundColor: Colors.black);
  }

  Widget _buildProductListingData(List<ProductListingModel> newsData) {
    return ListView.builder(
        itemCount: newsData.length,
        padding: const EdgeInsets.all(12.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _buildRow(newsData[i]);
        });
  }

  Widget _buildRow(ProductListingModel productListingData) {
    return Ink(
      child: ListTile(
        title: Text(productListingData.title,
            style: AppStyle.listViewTitleFontStyle),
        subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: buildChildLayout(productListingData)),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        onTap: () {
          //_pushNewsCategory(newsData);
        },
      ),
      color: Colors.grey,
    );
  }

  Column buildChildLayout(ProductListingModel productListingData) {
    return Column(children: <Widget>[
      Image.network(productListingData.urlToImage),
      Padding(padding: EdgeInsets.all(10)),
      Text(productListingData.description,
          style: AppStyle.listViewTitleFontStyle),
      Padding(padding: EdgeInsets.all(6)),
      Text(productListingData.content,
          style: AppStyle.listViewContentFontStyle),
      ButtonBar(
        children: <Widget>[
            _buildProductOrderCount(productListingData.title),
          
          FlatButton(
            color: Colors.black,
            child: const Text('Grab'),
            onPressed: () {
              _addProduct(productListingData.title, 1);
            },
          ),
          FlatButton(
            color: Colors.black,
            child: const Text('Remove'),
            onPressed: () {
              _removeProduct(productListingData.title, 1);
            },
          ),
        ],
      )
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  void _addProduct(String productName, int quantity) {
    if (productCount.keys.contains(productName)) {
      setState(() {
        productCount[productName] = productCount[productName] + quantity;
      });
    } else {
      setState(() {
        productCount[productName] = quantity;
      });
    }
  }

  void _removeProduct(String productName, int quantity) {
    if (productCount.keys.contains(productName)) {
      setState(() {
        productCount[productName] = productCount[productName] - quantity;
      });
    }
  }

  // Widget _buildProductOrderCount(int count) {
  //   if (count > 0) {
  //     return Text(count.toString(), style: AppStyle.listViewTitleFontStyle);
  //   } else {
  //     return Text("", style: AppStyle.listViewTitleFontStyle);
  //   }
  // }

  Widget _buildProductOrderCount(String title) {
    if (title != null && productCount.keys.contains(title)) {
      var count = productCount[title];
      return Text(count.toString(), style: AppStyle.listViewTitleFontStyle);
    } else {
      return Text("", style: AppStyle.listViewTitleFontStyle);
    }
  }
}
