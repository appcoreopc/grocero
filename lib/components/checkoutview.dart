import 'package:flutter/material.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/style/appstyle.dart';
import '../Appconstant.dart';



class CheckoutViewState<T extends StatefulWidget> extends State<T> {
  List<ProductListingModel> _customerOrderLists;
  Map<String, int> productCount = Map<String, int>();
  int indexCountRecord = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:
             _buildCustomerCheckoutLayout(_customerOrderLists),
        backgroundColor: Colors.black,
        bottomNavigationBar:
            NavigationHelper().CreateNavigationBar(this.context));
  }

  Widget _buildCustomerCheckoutLayout(List<ProductListingModel> newsData) {
    return Column(children: [
      Expanded(
          child: 
                 _buildRow("Deliver To", "Maggie")
             ),
      FlatButton(
        color: Colors.black,
        textColor: Colors.grey,
        child: Text('Make payment',
            style: AppStyle.checkoutFontContentFontStyle),
        onPressed: () {},
      )
    ]);
  }

  Widget _buildRow(String title, String subtitle) {
    return Ink(
      child: ListTile(
        title: Text(title,
            style: AppStyle.listViewTitleFontStyle),
        subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: buildChildLayout(title, subtitle)),
      ),
      color: Colors.grey,
    );
  }


  Column buildChildLayout(String title, String subtitle) {
    return Column(children: <Widget>[
     
      Padding(padding: EdgeInsets.all(Appconstant.ListViewPadding)),
      Text(title,
          style: AppStyle.listViewContentFontStyle),
      Text(subtitle,
          style: AppStyle.listViewContentFontStyle),
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
