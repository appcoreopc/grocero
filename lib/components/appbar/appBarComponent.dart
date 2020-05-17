import 'package:flutter/material.dart';
import '../../Appconstant.dart';

class AppBarComponent {
  static Widget createAppBarComponent(String appBarTitle) {
    return AppBar(
        iconTheme: IconThemeData(color: Appconstant.greenColor),
        title: Text(appBarTitle, style: TextStyle(color: Colors.black)),
        backgroundColor: Appconstant.primaryThemeColor);
  }
}
