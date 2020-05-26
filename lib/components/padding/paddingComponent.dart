import 'package:flutter/material.dart';

class PaddingComponent {
  static Widget buildEqualPaddingWidget(double paddingValue) {
    return Padding(padding: EdgeInsets.all(paddingValue));
  }

  static Widget buildPaddingLTRB(
      double left, double top, double right, double bottom) {
    return Padding(padding: EdgeInsets.fromLTRB(left, top, right, bottom));
  }
}
