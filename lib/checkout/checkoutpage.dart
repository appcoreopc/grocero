import 'package:flutter/material.dart';
import 'package:grocero/components/checkoutview.dart';

class CheckoutPage extends StatefulWidget {

  static const routeName = '/checkout';
  String title;
  String message;

  @override
  State<StatefulWidget> createState() => CheckoutViewState();
}
