import 'package:flutter/material.dart';
import 'package:grocero/style/appstyle.dart';

import '../../Appconstant.dart';

class ButtonComponent {
  static Widget createExtendedButton(
      BuildContext ctx, Function _proceedToCheckOutFunction) {
    return Container(
        color: Colors.transparent,
        width: MediaQuery.of(ctx).size.width,
        height: 60,
        child: FlatButton(
          color: Appconstant.greenColor,
          textColor: Appconstant.appCheckoutPaymentTextColor,
          child: Text(Appconstant.proceedToCheckout,
              style: AppStyle.checkoutButtonFontContentFontStyle),
          onPressed: () {
            _proceedToCheckOutFunction();
          },
        ));
  }
}
