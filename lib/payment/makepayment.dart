import 'package:flutter/material.dart';
import 'package:grocero/components/makepaymentpagestate.dart';
import 'package:grocero/models/cartproducts.dart';

class MakePaymentPage extends StatefulWidget {
  MakePaymentPage(this._cartProduct);

  static const routeName = '/makepayment';

  CartProduct _cartProduct;

  @override
  State<StatefulWidget> createState() =>
      MakePaymentPageState(this._cartProduct);
}
