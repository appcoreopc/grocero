import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocero/Appconstant.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/services/mock/mockmarkerservice.dart';
import 'package:grocero/style/appstyle.dart';

class ProductListViewState<T extends StatefulWidget> extends State<T> {
  Future<List<ProductListingModel>> _futureDataSource;
  Map<String, int> productCount = Map<String, int>();
  List<ProductListingModel> _productListing;
  NotificationRenderType _notificationRenderingType = NotificationRenderType.none; 
  int pageIndex = 1;
 

  @override
  void initState() {
    super.initState();
    _futureDataSource = MockDataService.GetProductListing();
  }

  @override
  Widget build(BuildContext context) {
    _futureDataSource = MockDataService.GetProductListing();

    return SafeArea(
        child: Scaffold(
            body: FutureBuilder<List<ProductListingModel>>(
              future: _futureDataSource,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _productListing = snapshot.data;
                  return _buildProductListingData(_productListing);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
            backgroundColor: Appconstant.appDefaultBackgroundColor,
            bottomNavigationBar: NavigationHelper().CreateNavigationBar(
                this.context,
                CartProduct(this.productCount, 
                this._productListing, 
                _notificationRenderingType, pageIndex),
                )));
  }

  Widget _buildProductListingData(List<ProductListingModel> productLists) {
    return ListView.builder(
        itemCount: productLists.length,
        padding: const EdgeInsets.all(12.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _buildRow(productLists[i]);
        });
  }

  Widget _buildRow(ProductListingModel productListingData) {
    return Ink(
      child: ListTile(
        subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: buildChildLayout(productListingData)),
      ),
      color: Appconstant.appDefaultTextColor,
    );
  }

  Column buildChildLayout(ProductListingModel productListingData) {
    return Column(children: <Widget>[
      Image.network(productListingData.urlToImage),
      Padding(padding: EdgeInsets.all(Appconstant.listViewPadding)),
      Text(productListingData.title, style: AppStyle.listViewContentFontStyle),
      Padding(padding: EdgeInsets.all(Appconstant.listViewPadding)),
      Text(productListingData.description,
          style: AppStyle.listViewContentFontStyle),
      Text(productListingData.content,
          style: AppStyle.listViewContentFontStyle),
      ButtonBar(
        children: <Widget>[
          _buildProductOrderCount(productListingData.title),
          FlatButton(
            color: Appconstant.appDefaultBackgroundColor,
            child: Text(Appconstant.addToCartText),
            onPressed: () {
              _addProduct(productListingData.title, 1);

            },
          ),
        ],
      )
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  void _addProduct(String productName, int quantity) {
    int totalOrderItem = 0;

    if (productCount.keys.contains(productName)) {
      totalOrderItem = productCount[productName] + quantity;
    } else {
      totalOrderItem = quantity;
    }

    if (totalOrderItem > 0) {
      setState(() {
        productCount[productName] = totalOrderItem;
        _notificationRenderingType = NotificationRenderType.simpleDot;
      });
    }
  }

  Widget _buildProductOrderCount(String title) {
    int count = 0;
    if (title != null && productCount.keys.contains(title)) {
      count = productCount[title];
    }
    return Text(count.toString(), style: AppStyle.listViewTitleFontStyle);
  }
}
