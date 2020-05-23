import 'package:flutter/material.dart';
import 'package:grocero/appconstant.dart';
import 'package:grocero/models/paymentmethod.dart';
import 'package:grocero/style/appstyle.dart';
import 'appbar/appBarComponent.dart';
import 'inputcomponents/passwordtextfield.dart';

class SignUpPageState<T extends StatefulWidget> extends State<T> {
  SignUpPageState();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
            child: Scaffold(
      appBar:
          AppBarComponent.createAppBarComponent(Appconstant.signUpPageTitle),
      body: _buildCustomerCheckoutLayout(),
      backgroundColor: Appconstant.allWhite,
    )));
  }

  Widget _buildCustomerCheckoutLayout() {
    return Form(
        key: _formKey,
        autovalidate: true,
        child: Column(children: <Widget>[
          Expanded(
              child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
              _buildInputFieldLayout(
                  "Username",
                  null,
                  "Please provide username",
                  Icon(Icons.person),
                  _creditCardTextChanged),
              _buildInputFieldLayout(
                  "Email",
                  null,
                  "Please provide a valid email address",
                  Icon(Icons.email),
                  _textChanged),
              _buildPasswordInputFieldLayout(
                  "Password",
                  null,
                  "Please provide a password",
                  Icon(Icons.format_list_numbered),
                  _textChanged),
            ],
          )),
          Container(
              color: Colors.transparent,
              //width: MediaQuery.of(context).size.width,
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
        ]));
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

  Widget _buildPasswordInputFieldLayout(
      String title,
      String initialValueTextData,
      String validationMessage,
      Icon targetIcon,
      Function(String) onTextChanged) {
    return Ink(
      child: ListTile(
          subtitle: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: PasswordField(
          fieldKey: _passwordFieldKey,
          helperText: title,
          labelText: title,
          onFieldSubmitted: (value) {
            setState(() {
              // person.password = value;
            });
          },
        ),
      )),
      color: Appconstant.allWhite,
    );
  }

  void _completePayment() {}

  void _updatePaymentMethod(PaymentMethod paymentMethod) {
    setState(() {});
  }

  void _textChanged(String value) {}
}

void _creditCardTextChanged(String value) {}
