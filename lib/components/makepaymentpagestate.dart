import 'package:flutter/material.dart';
import 'package:grocero/appconstant.dart';
import 'package:grocero/cart/notificationRenderType.dart';
import 'package:grocero/models/cartproducts.dart';
import 'package:grocero/models/paymentmethod.dart';
import 'package:grocero/models/productlistingmodel.dart';
import 'package:grocero/navigations/navigationhelper.dart';
import 'package:grocero/style/appstyle.dart';
import 'appbar/appBarComponent.dart';
import 'formatters/maskinputformatter.dart';

class MakePaymentPageState<T extends StatefulWidget> extends State<T> {
  MakePaymentPageState(this._cartProduct);

  List<ProductListingModel> _customerOrderLists;
  Map<String, int> _productCount = Map<String, int>();
  CartProduct _cartProduct;
  NotificationRenderType _notificationRenderType = NotificationRenderType.none;
  int pageIndex =
      2; // *** Keep the selecte page index to cart, as there is no page ****
  PaymentMethod _paymentMethod = PaymentMethod.creditCard;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _customerOrderLists = _cartProduct.productListings;
    _productCount = _cartProduct.productCount;
    _notificationRenderType = _cartProduct.notificationRenderType;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidate: true,
        child: SafeArea(
            child: Scaffold(
                appBar: AppBarComponent.createAppBarComponent(
                    Appconstant.paymentNavBarText),
                body: _buildCustomerCheckoutLayout(_customerOrderLists),
                backgroundColor: Appconstant.allWhite,
                bottomNavigationBar: NavigationHelper().CreateNavigationBar(
                    this.context,
                    CartProduct(_productCount, this._customerOrderLists,
                        _notificationRenderType, pageIndex)))));
  }

  Widget _buildCustomerCheckoutLayout(List<ProductListingModel> newsData) {
    return Column(children: <Widget>[
      Expanded(
          child: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          _buildCheckoutRowLayout(
              "Credit card", "", "", PaymentMethod.creditCard),
          _buildCreditCardInputFieldLayout("Credit Card", "VISA", "Update",
              Icon(Icons.credit_card), _creditCardTextChanged),
          _buildInputFieldLayout(
              "EXPIRY DATE",
              "",
              "Please enter a valid expiry date",
              Icon(Icons.calendar_today),
              _textChanged),
          _buildInputFieldLayout("CVE", "", "Please enter your civ number",
              Icon(Icons.format_list_numbered), _textChanged),
          _buildCheckoutRowLayout(
              "Cash on delivery", "", "", PaymentMethod.cashOnDelivery)
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
              _completePayment();
            },
          ))
    ]);
  }

  Widget _buildCheckoutRowLayout(String title, String subtitle,
      String commandString, PaymentMethod paymentMethod) {
    return Ink(
      child: ListTile(
        title: Text(title, style: AppStyle.listViewTitleFontStyle),
        leading: Radio(
            groupValue: _paymentMethod,
            value: paymentMethod,
            onChanged: _updatePaymentMethod),
      ),
      color: Appconstant.allWhite,
    );
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
                enabled: (_paymentMethod == PaymentMethod.creditCard),
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

  Widget _buildCreditCardInputFieldLayout(
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
                inputFormatters: [
                  MaskedTextInputFormatter(
                    mask: 'xxxx-xxxx-xxxx-xxxx',
                    separator: '-',
                  )
                ],
                enabled: (_paymentMethod == PaymentMethod.creditCard),
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

  void _completePayment() {}

  void _updatePaymentMethod(PaymentMethod paymentMethod) {
    setState(() {
      _paymentMethod = paymentMethod;
    });
  }

  void _textChanged(String value) {}
}

void _creditCardTextChanged(String value) {}
