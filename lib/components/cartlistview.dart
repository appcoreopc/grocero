import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocero/checkout/checkoutpage.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/services/mock/mockmarkerservice.dart';
import 'package:grocero/style/appstyle.dart';
import '../Appconstant.dart';

class CartListViewState<T extends StatefulWidget> extends State<T> {
  Future<List<ProductListingModel>> _futureDataSource;
  Map<String, int> productCount = Map<String, int>();
  int indexCountRecord = 0;

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
        backgroundColor: Colors.black,
        bottomNavigationBar:
            NavigationHelper().CreateNavigationBar(this.context));
  }

  Widget _buildProductListingData(List<ProductListingModel> newsData) {
    return Column(children: [
      Expanded(
          child: ListView.builder(
              itemCount: newsData.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                if (index.isOdd) return Divider();
                return _buildRow(newsData[index], index);
              })),
      FlatButton(
        color: Colors.black,
        textColor: Colors.grey,
        child: Text('Proceed to checkout',
            style: AppStyle.checkoutFontContentFontStyle),
        onPressed: () {

                _proceedToCheckOut(productCount);

        },
      )
    ]);
  }

  Widget _buildRow(ProductListingModel productListingData, int index) {
    return Ink(
      child: ListTile(
        title: Text(productListingData.title,
            style: AppStyle.listViewTitleFontStyle),
        subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: buildChildLayout(productListingData, index)),
      ),
      color: Colors.grey,
    );
  }

  Column buildChildLayout(ProductListingModel productListingData, int index) {
    return Column(children: <Widget>[
      Image.network(productListingData.urlToImage),
      Padding(padding: EdgeInsets.all(Appconstant.ListViewPadding)),
      Text(productListingData.title, style: AppStyle.listViewContentFontStyle),
      Padding(padding: EdgeInsets.all(Appconstant.ListViewPadding)),
      Text(productListingData.description,
          style: AppStyle.listViewContentFontStyle),
      Text(productListingData.content,
          style: AppStyle.listViewContentFontStyle),
      ButtonBar(
        children: <Widget>[
          FlatButton(
            color: Colors.black,
            child: const Text('Add'),
            onPressed: () {
              _addProduct(productListingData.title, 1);
            },
          ),
          _buildProductOrderCount(productListingData.title),
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
      final currentCount = productCount[productName];
      if (currentCount > 0) {
        setState(() {
          productCount[productName] = currentCount - quantity;
        });
      }
    }
  }

  Widget _buildProductOrderCount(String title) {
    if (title != null && productCount.keys.contains(title)) {
      var count = productCount[title];

      if (count > 0) {
        return Text(count.toString(), style: AppStyle.listViewTitleFontStyle);
      }
    }
    return Text("  ", style: AppStyle.listViewTitleFontStyle);
  }

  void _proceedToCheckOut(Map<String, int> productCount) {
    NavigationHelper.NavigateTo(this.context, CheckoutPage.routeName, null);
  }
}
