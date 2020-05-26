import 'package:flutter/material.dart';
import 'package:grocero/appconstant.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/components/padding/paddingComponent.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/customerInfo.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/payment/makepayment.dart';
import 'package:grocero/style/appstyle.dart';
import 'appbar/appBarComponent.dart';

class CheckoutViewState<T extends StatefulWidget> extends State<T> {
  CheckoutViewState(this._cartProduct);

  List<ProductListingModel> _customerOrderLists;
  Map<String, int> _productCount = Map<String, int>();
  CartProduct _cartProduct;
  NotificationRenderType _notificationRenderType = NotificationRenderType.none;
  int pageIndex =
      2; // *** Keep the selecte page index to cart, as there is no page ****
  double totalAmount = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _customerOrderLists = _cartProduct.productListings;
    _productCount = _cartProduct.productCount;
    _notificationRenderType = _cartProduct.notificationRenderType;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _calculateTotal();

    return Form(
        key: _formKey,
        autovalidate: true,
        child: SafeArea(
            child: Scaffold(
                appBar: AppBarComponent.createAppBarComponent(
                    Appconstant.shippingNavBarText),
                body: _buildCustomerCheckoutLayout(),
                backgroundColor: Appconstant.allWhite,
                bottomNavigationBar: NavigationHelper().CreateNavigationBar(
                    this.context,
                    CartProduct(_productCount, this._customerOrderLists,
                        _notificationRenderType, pageIndex)))));
  }

  Widget _buildCustomerCheckoutLayout() {
    if (_validateCount(_productCount)) {
      return buildBillingTotalLayout();
    } else {
      return _buildNoItemCartLayout();
    }
  }

  bool _validateCount(Map<String, int> source) {
    for (var element in source.values) {
      if (element > 0) {
        return true;
      }
    }
    return false;
  }

  void _nameChanged(String value) {
    _cartProduct.customerInfo.name = value;
  }

  void _contactChanged(String value) {
    _validateCartCustomerInfo();
    _cartProduct.customerInfo.contact = value;
  }

  void _addresssChanged(String value) {
    _validateCartCustomerInfo();
    _cartProduct.customerInfo.address = value;
  }

  void _validateCartCustomerInfo() {
    if (_cartProduct.customerInfo == null) {
      _cartProduct.customerInfo = CustomerInfo();
    }
  }

  Widget buildBillingTotalLayout() {
    return Column(children: <Widget>[
      Expanded(
          child: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 12, 4, 0)),
          _buildInputFieldLayout(Appconstant.customerCheckoutNameText, "Maggie",
              "Please enter name", Icon(Icons.person), _nameChanged),

          _buildInputFieldLayout(
              Appconstant.customerCheckoutPhoneText,
              "11-012301230",
              "Please enter contact number",
              Icon(Icons.phone),
              _contactChanged),
          _buildInputFieldLayout(
              Appconstant.customerCheckoutAddressText,
              "123 Namsan Close",
              "Please enter shipping address address",
              Icon(Icons.local_shipping),
              _addresssChanged),
          _buildDeliveryTimeLayout(),
          ////////////// Delivery time ////////
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

  Widget _buildInputFieldLayout(
      String title,
      String initialValueTextData,
      String validationMessage,
      Icon targetIcon,
      Function(String) onTextChanged) {
    return Ink(
      child: ListTile(
          subtitle: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                initialValue: initialValueTextData,
                onChanged: onTextChanged,
                cursorColor: Theme.of(context).cursorColor,
                decoration: InputDecoration(
                    hintText: title, labelText: title, icon: targetIcon),
                validator: (value) {
                  if (value.isEmpty) {
                    return validationMessage;
                  }
                  return null;
                },
              ))),
      color: Appconstant.allWhite,
    );
  }

  Widget _buildTotalCheckoutRowLayout(
      String title, String subtitle, String commandString) {
    return Ink(
      child: ListTile(
        title: Text(title + ":" + subtitle, style: AppStyle.bigTotalStyle),
      ),
      color: Appconstant.allWhite,
    );
  }

  var _deliveryTimeSelected = <bool>[false, false, false, false, false, false];

  Widget _buildDeliveryTimeLayout() {
    return Column(
      children: <Widget>[
        PaddingComponent.buildEqualPaddingWidget(10),
        _buildAvailableTimeLayout(),
        PaddingComponent.buildEqualPaddingWidget(4),
      ],
    );
  }

  Widget _buildAvailableTimeLayout() {
    return ToggleButtons(
      selectedColor: Appconstant.allWhite,
      fillColor: Appconstant.greenColor,
      children: <Widget>[
        Text("10:00"),
        Text("12:00"),
        Text("14:00"),
        Text("12:00"),
        Text("14:00"),
        Text("16:00"),
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < _deliveryTimeSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              _deliveryTimeSelected[buttonIndex] =
                  !_deliveryTimeSelected[buttonIndex];
            } else {
              _deliveryTimeSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: _deliveryTimeSelected,
    );
  }

  Column _buildChildLayout(String title, String subtitle) {
    return Column(children: <Widget>[
      Padding(padding: EdgeInsets.all(Appconstant.listViewPadding)),
      Text(subtitle, style: AppStyle.totalAmountContentGreyFontStyle),
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }

  void _makePayment() {
    if (_formKey.currentState.validate()) {
      NavigationHelper.NavigateTo(
          this.context, MakePaymentPage.routeName, this._cartProduct);
    }
  }

  void _calculateTotal() {
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

  Widget _buildNoItemCartLayout() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(Appconstant.noItemInCartMessage,
              style: AppStyle.totalAmountContentGreyFontStyle)
        ]));
  }
}
