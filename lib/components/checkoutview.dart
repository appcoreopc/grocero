import 'package:flutter/material.dart';
import 'package:grocero/appconstant.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/style/appstyle.dart';

class CheckoutViewState<T extends StatefulWidget> extends State<T> {
  CheckoutViewState(this._cartProduct);

  List<ProductListingModel> _customerOrderLists;
  Map<String, int> _productCount = Map<String, int>();
  CartProduct _cartProduct;
  NotificationRenderType _notificationRenderType = NotificationRenderType.none;
  int pageIndex = 3; 
  
  @override
  void initState() {
    super.initState();
    _customerOrderLists = _cartProduct.productListings;
    _productCount = _cartProduct.productCount;
    _notificationRenderType = _cartProduct.notificationRenderType;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: _buildCustomerCheckoutLayout(_customerOrderLists),
            backgroundColor: Appconstant.appDefaultBackgroundColor,
            bottomNavigationBar: NavigationHelper().CreateNavigationBar(
                this.context,
                CartProduct(_productCount, this._customerOrderLists, _notificationRenderType, pageIndex))));
  }

  Widget _buildCustomerCheckoutLayout(List<ProductListingModel> newsData) {
    return Column(children: <Widget>[
      Expanded(
          child: Column(
        children: [
          _buildCheckoutRowLayout(
              Appconstant.customerCheckoutNameText, "Maggie", "Update"),
          _buildCheckoutRowLayout(
              Appconstant.customerCheckoutPhoneText, "Maggie", "Change"),
          _buildCheckoutRowLayout(
              Appconstant.customerCheckoutAddressText, "Maggie", "Change"),
          _buildCheckoutRowLayout(
              Appconstant.customerCheckoutDeliveryTimeText, "Maggie", "Change"),
          _buildCheckoutRowLayout(
              Appconstant.customerCheckoutTotalText, "", ""),
        ],
      )),
      Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: FlatButton(
            color: Appconstant.appCheckoutPaymentBackgroundColor,
            textColor: Appconstant.appCheckoutPaymentTextColor,
            child: Text(Appconstant.makePaymentText,
                style: AppStyle.checkoutButtonFontContentFontStyle),
            onPressed: () {},
          ))
    ]);
  }

  Widget _buildCheckoutRowLayout(
      String title, String subtitle, String commandString) {
    return Ink(
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
      //Text(title, style: AppStyle.listViewContentFontStyle),
      Text(subtitle, style: AppStyle.listViewContentFontStyle),
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }
}
