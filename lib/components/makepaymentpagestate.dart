import 'package:flutter/material.dart';
import 'package:grocero/appconstant.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/style/appstyle.dart';

class MakePaymentPageState<T extends StatefulWidget> extends State<T> {
  MakePaymentPageState(this._cartProduct);

  List<ProductListingModel> _customerOrderLists;
  Map<String, int> _productCount = Map<String, int>();
  CartProduct _cartProduct;
  NotificationRenderType _notificationRenderType = NotificationRenderType.none;
  int pageIndex =
      2; // *** Keep the selecte page index to cart, as there is no page ****

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
            backgroundColor: Appconstant.allWhite,
            bottomNavigationBar: NavigationHelper().CreateNavigationBar(
                this.context,
                CartProduct(_productCount, this._customerOrderLists,
                    _notificationRenderType, pageIndex))));
  }

  Widget _buildCustomerCheckoutLayout(List<ProductListingModel> newsData) {
    return Column(children: <Widget>[
      Expanded(
          child: Column(
        children: [
          _buildCheckoutRowLayout(
              "Payment method", "VISA", "Update"),
          
        ],
      )),
      Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: FlatButton(
            color: Appconstant.greenColor,
            textColor: Appconstant.appCheckoutPaymentTextColor,
            child: Text(Appconstant.completePaymentText,
                style: AppStyle.checkoutButtonFontContentFontStyle),
            onPressed: () {
              _makePaymnet();
            },
          ))
    ]);
  }

  Widget _buildCheckoutRowLayout(
      String title, String subtitle, String commandString) {
    return Ink(
      child: ListTile(
        title: Text(title, style: AppStyle.listViewTitleFontStyle),
        subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: buildChildLayout(title, subtitle)),
        trailing: FlatButton(
          child: Text(
            commandString,
          ),
          textColor: Appconstant.greenColor,
          onPressed: () => {},
        ),
      ),
      color: Appconstant.allWhite,
    );
  }

  Column buildChildLayout(String title, String subtitle) {
    return Column(children: <Widget>[
      Padding(padding: EdgeInsets.all(Appconstant.listViewPadding)),
      Text(subtitle, style: AppStyle.listViewContentGreyFontStyle),
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  void _makePaymnet() {}
}
