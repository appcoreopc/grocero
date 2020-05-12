import 'package:flutter/material.dart';
import 'package:grocero/appconstant.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/style/appstyle.dart';

class CheckoutViewState<T extends StatefulWidget> extends State<T> {
  List<ProductListingModel> _customerOrderLists;
  Map<String, int> productCount = Map<String, int>();
  int indexCountRecord = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildCustomerCheckoutLayout(_customerOrderLists),
        backgroundColor: Appconstant.appDefaultBackgroundColor,
        bottomNavigationBar:
            NavigationHelper().CreateNavigationBar(this.context));
  }

  Widget _buildCustomerCheckoutLayout(List<ProductListingModel> newsData) {
    return Column(children: [

      _buildCheckoutRowLayout("Customer Name", "Maggie", "Update"),
      _buildCheckoutRowLayout("Contact", "Maggie", "Change"),
      _buildCheckoutRowLayout("Address", "Maggie", "Change"),
      _buildCheckoutRowLayout("Delivery Time", "Maggie", "Change"),

      FlatButton(
        color: Appconstant.appDefaultBackgroundColor,
        textColor: Appconstant.appDefaultTextColor,
        child:
            Text('Make payment', style: AppStyle.checkoutFontContentFontStyle),
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
    if (title != null && productCount.keys.contains(title)) {
      var count = productCount[title];

      if (count > 0) {
        return Text(count.toString(), style: AppStyle.listViewTitleFontStyle);
      }
    }
    return Text("  ", style: AppStyle.listViewTitleFontStyle);
  }
}
