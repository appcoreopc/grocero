import 'package:flutter/material.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/checkout/checkoutpage.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/style/appstyle.dart';
import '../Appconstant.dart';

class CartListViewState<T extends StatefulWidget> extends State<T> {
  CartListViewState(this._cartProduct);
  CartProduct _cartProduct;
  NotificationRenderType _notificationRenderType = NotificationRenderType.none;
  
  Map<String, int> _productCount = Map<String, int>();
  List<ProductListingModel> _productListing = List<ProductListingModel>();
  int pageIndex = 2;

  @override
  void initState() {
    super.initState();

    _productCount = _cartProduct.productCount;
    _notificationRenderType = _cartProduct.notificationRenderType;
    getMatchingProduct(_cartProduct);
  }

  void getMatchingProduct(CartProduct cartProduct) {
    if (cartProduct.productCount != null &&
        cartProduct.productListings != null) {
      cartProduct.productCount.forEach((x, i) => _productListing.addAll(
          cartProduct.productListings.where((element) => element.title == x)));
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: _buildProductListingData(this._productListing),
            backgroundColor: Appconstant.appDefaultBackgroundColor,
            bottomNavigationBar: NavigationHelper().CreateNavigationBar(
                this.context,
                CartProduct(this._productCount, this._productListing, _notificationRenderType, pageIndex))));
  }

  Widget _buildProductListingData(List<ProductListingModel> _productListing) {
    return Column(children: [
      Expanded(
          child: ListView.builder(
              itemCount: _productListing.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                if (index.isOdd) return Divider();
                return _buildRow(_productListing[index], index);
              })),
      Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: FlatButton(
            color: Appconstant.appCheckoutPaymentBackgroundColor,
            textColor: Appconstant.appCheckoutPaymentTextColor,
            child: Text(Appconstant.productListingProceedToCheckout,
                style: AppStyle.checkoutButtonFontContentFontStyle),
            onPressed: () {
              _proceedToCheckOut();
            },
          ))
    ]);
  }

  Widget _buildRow(ProductListingModel productListingData, int index) {
    return Ink(
      child: ListTile(
        title: Text(productListingData.title,
            style: AppStyle.listViewTitleFontStyle),
        subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: buildChildLayout(productListingData)),
      ),
      color: Colors.grey,
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
          FlatButton(
            color: Appconstant.appDefaultBackgroundColor,
            child: Text(Appconstant.addProductToCartText),
            onPressed: () {
              _addProduct(productListingData.title, 1);
            },
          ),
          _buildProductOrderCount(productListingData.title),
          FlatButton(
            color: Appconstant.appDefaultBackgroundColor,
            child: Text(Appconstant.removeProuctFromCartText),
            onPressed: () {
              _removeProduct(productListingData.title, 1);
            },
          ),
        ],
      )
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  void _addProduct(String productName, int quantity) {
    if (_productCount.keys.contains(productName)) {
      setState(() {
        _productCount[productName] = _productCount[productName] + quantity;
      });
    } else {
      setState(() {
        _productCount[productName] = quantity;
      });
    }
  }

  void _removeProduct(String productName, int quantity) {
    if (_productCount.keys.contains(productName)) {
      final currentCount = _productCount[productName];
      if (currentCount > 0) {
        setState(() {
          _productCount[productName] = currentCount - quantity;
        });
      }
    }
  }

  Widget _buildProductOrderCount(String title) {
    int count = 0;

    if (title != null && _productCount.keys.contains(title)) {
      count = _productCount[title];
    }
    return Text(count.toString(), style: AppStyle.listViewTitleFontStyle);
  }

  void _proceedToCheckOut() {
    NavigationHelper.NavigateTo(this.context, CheckoutPage.routeName,
        CartProduct(_productCount, _productListing, _notificationRenderType, 2));
  }
}