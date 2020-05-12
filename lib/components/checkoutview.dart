import 'package:flutter/material.dart';
import 'package:grocero/appconstant.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/style/appstyle.dart';

class CheckoutViewState<T extends StatefulWidget> extends State<T> {

  CheckoutViewState(this._cartProduct);

  List<ProductListingModel> _customerOrderLists;
  Map<String, int> _productCount = Map<String, int>();
  int indexCountRecord = 0;
  CartProduct _cartProduct; 

    @override
  void initState() {
    super.initState();
    _cartProduct.productListings = _customerOrderLists; 
    _cartProduct.productCount = _productCount; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildCustomerCheckoutLayout(_customerOrderLists),
        backgroundColor: Appconstant.appDefaultBackgroundColor,
        bottomNavigationBar:
            NavigationHelper().CreateNavigationBar(this.context, CartProduct(_productCount, this._customerOrderLists)));
  }

  Widget _buildCustomerCheckoutLayout(List<ProductListingModel> newsData) {
    return Column(children: [

      _buildCheckoutRowLayout(Appconstant.customerCheckoutNameText, "Maggie", "Update"),
      _buildCheckoutRowLayout(Appconstant.customerCheckoutPhoneText, "Maggie", "Change"),
      _buildCheckoutRowLayout(Appconstant.customerCheckoutAddressText, "Maggie", "Change"),
      _buildCheckoutRowLayout(Appconstant.customerCheckoutDeliveryTimeText, "Maggie", "Change"),

      FlatButton(
        color: Appconstant.appDefaultBackgroundColor,
        textColor: Appconstant.appDefaultTextColor,
        child:
            Text(Appconstant.makePaymentText, style: AppStyle.checkoutFontContentFontStyle),
        onPressed: () {},
      )
    ]);
  }

  Widget _buildCheckoutRowLayout(
      String title, String subtitle, String commandString) {
    return 
    Ink(
      child: ListTile(
        title: Text(title, style: AppStyle.listViewTitleFontStyle),
        subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: buildChildLayout(title, subtitle)),
        trailing: FlatButton(
          child: Text(
            commandString,
          ),
          onPressed: () => {},
        ),
      ),
      color: Appconstant.appDefaultTextColor,
    );
  }

  Column buildChildLayout(String title, String subtitle) {
    return Column(children: <Widget>[
      Padding(padding: EdgeInsets.all(Appconstant.listViewPadding)),
      Text(title, style: AppStyle.listViewContentFontStyle),
      Text(subtitle, style: AppStyle.listViewContentFontStyle),
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget _buildProductOrderCount(String title) {

    int count = 0;
    if (title != null && _productCount.keys.contains(title)) {
      count = _productCount[title];
    }
    return Text(count.toString(),style: AppStyle.listViewTitleFontStyle);
  }
}
