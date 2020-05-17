import 'package:flutter/material.dart';
import 'package:grocero/appconstant.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/payment/makepayment.dart';
import 'package:grocero/style/appstyle.dart';

class CheckoutViewState<T extends StatefulWidget> extends State<T> {
  CheckoutViewState(this._cartProduct);

  List<ProductListingModel> _customerOrderLists;
  Map<String, int> _productCount = Map<String, int>();
  CartProduct _cartProduct;
  NotificationRenderType _notificationRenderType = NotificationRenderType.none;
  int pageIndex =
      2; // *** Keep the selecte page index to cart, as there is no page ****
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _customerOrderLists = _cartProduct.productListings;
    _productCount = _cartProduct.productCount;
    _notificationRenderType = _cartProduct.notificationRenderType;
  }

  @override
  Widget build(BuildContext context) {
    calculateTotal();

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Appconstant.greenColor),
                title: Text("Shipping info",
                    style: TextStyle(color: Colors.black)),
                backgroundColor: Appconstant.primaryThemeColor),
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
          Padding(padding: EdgeInsets.fromLTRB(0, 12, 4, 0)),
          _buildCheckoutRowLayout(
              Appconstant.customerCheckoutNameText, "Maggie", "Update"),
          _buildCheckoutRowLayout(
              Appconstant.customerCheckoutPhoneText, "Maggie", "Change"),
          _buildCheckoutRowLayout(
              Appconstant.customerCheckoutAddressText, "Maggie", "Change"),
          _buildCheckoutRowLayout(
              Appconstant.customerCheckoutDeliveryTimeText, "Maggie", "Change"),
          _buildTotalCheckoutRowLayout(Appconstant.customerCheckoutTotalText,
              totalAmount.toString(), ""),
        ],
      )),
      Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: FlatButton(
            color: Appconstant.greenColor,
            textColor: Appconstant.appCheckoutPaymentTextColor,
            child: Text(Appconstant.makePaymentText,
                style: AppStyle.checkoutButtonFontContentFontStyle),
            onPressed: () {
              _makePayment();
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

  Widget _buildTotalCheckoutRowLayout(
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

  Column buildTotalAmountChildLayout(String title, String subtitle) {
    return Column(children: <Widget>[
      Padding(padding: EdgeInsets.all(Appconstant.listViewPadding)),
      Text(subtitle, style: AppStyle.totalAmountContentGreyFontStyle),
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  void _makePayment() {
    NavigationHelper.NavigateTo(
        this.context, MakePaymentPage.routeName, this._cartProduct);
  }

  void calculateTotal() {
    double totalAmountToPay = 0;
    for (var element in _productCount.entries) {
      if (_customerOrderLists != null && _customerOrderLists.isNotEmpty) {
        var productItem =
            _customerOrderLists.singleWhere((a) => a.title == element.key);

        if (productItem.price > 0) {
          var subtotal = productItem.price * element.value;
          totalAmountToPay += subtotal;
        }
      }
    }

    this._cartProduct.totalAmount = totalAmount;

    setState(() {
      totalAmount = totalAmountToPay;
    });
  }
}
