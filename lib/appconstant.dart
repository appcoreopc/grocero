import 'package:flutter/material.dart';
import 'package:grocero/util/colorUtil.dart';

class Appconstant {
  static String grabButtonText = "Grab";
  static String removeButtonText = "Remove";
  static String stringEmpty = "";
  static String homeMenuText = "Home";
  static String exploreMenuText = "Explore";
  static String cartMenuText = "Cart";
  static double listViewPadding = 4;

  static Color appDefaultBackgroundColor = Colors.black;
  static Color appDefaultTextColor = Colors.grey;

  static Color appCheckoutPaymentBackgroundColor = Colors.grey;
  static Color appCheckoutPaymentTextColor = Colors.black;

  static String addToCartText = "Add to cart";
  static String makePaymentText = "Make a payment";
  static String completePaymentText = "Complete order";
  static String signUpText = "Sign up";
  static String customerCheckoutNameText = "Customer Name";
  static String customerCheckoutDeliveryToText = "Delivery To";
  static String customerCheckoutPhoneText = "Contact";
  static String customerCheckoutAddressText = "Delivery Address";
  static String customerCheckoutDeliveryTimeText = "Delivery Address";
  static String proceedToCheckout = "Proceed to checkout";
  static String addProductToCartText = "Add";
  static String removeProuctFromCartText = "Remove";
  static String setCurrentLocationText = 'Set current location';

  static String shippingNavBarText = "Shipping info";
  static String paymentNavBarText = "Payment Method";
  
  static String signUpPageTitle = "Sign up";
  
  static String customerCheckoutTotalText = "Total";
  static String homePageText = "Home";
  static String homePageExploreByCategoryText = "Shop by category";
  static String homePageTopSellingText = "Top sellers";
  static double homePageTitleFontSize = 22;
  static int gridDefaultColumnSize = 2;

  static String noItemInCartMessage = "There is no item in cart.";

  static const Color primaryThemeColor = Colors.white;
  static const Color secondaryThemeColor = Color(0xFF);
  static const Color textColorSecondaryTextColor = Colors.grey;

  static Color greenColor = ColorUtil.hexcolor("#00BE74");
  static Color allGreyColor = ColorUtil.hexcolor("#ABB0B6");
  static Color allBlack = ColorUtil.hexcolor("#181818");
  static Color allWhite = ColorUtil.hexcolor("#FFFFFF");

  static String enterValidPasswordMessage = "Please enter a valid password";
  static String provideValidValueMessage = "Please provide a value";
  static String ensurePasswordAreTheSameMessage = "Please ensure password are the same";

  static String usernameTextboxTitle = "Username";
  static String usernameValidationMessage = "Please provide a username";

  static String emailTitle = "Email";
  static String emailValidationMessage = "Please provide a valid email address";

  static String passwordTitle = "Password";
  static String passwordValidationMessage = "Please provide a password";

  static String confirmPasswordTitle = "Confirm password";
  static String confirmPasswordValidationMessage = "Please ensure your password are the same";


}
