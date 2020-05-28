import 'package:flutter/material.dart';
import 'package:grocero/components/inputcomponents/passwordtextfield.dart';
import 'package:grocero/components/padding/paddingComponent.dart';
import 'package:grocero/models/usersignup.dart';
import 'package:grocero/style/appstyle.dart';
import '../../appconstant.dart';

class SignUpComponent extends StatelessWidget {
  SignUpComponent(this.context);
  BuildContext context;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();
  UserSignUpModel userSignUp = UserSignUpModel();
  FocusNode passwordFocus;

  @override
  Widget build(BuildContext context) {
    return _buildCustomerCheckoutLayout();
  }

  Widget _buildCustomerCheckoutLayout() {
    return Form(
        key: _formKey,
        autovalidate: true,
        child: Column(children: <Widget>[
          Expanded(
              child: Column(
            children: [
              PaddingComponent.buildPaddingLTRB(0, 20, 0, 0),
              _buildInputFieldLayout(
                  Appconstant.usernameTextboxTitle,
                  null,
                  Appconstant.usernameValidationMessage,
                  Icon(Icons.person),
                  false,
                  _usernameChanged,
                  _validateEmptyValueWidget),
              _buildInputFieldLayout(
                  Appconstant.emailTitle,
                  null,
                  Appconstant.emailValidationMessage,
                  Icon(Icons.email),
                  false,
                  _emailChanged,
                  _validateEmptyValueWidget),
              _buildPasswordInputFieldLayout(Appconstant.passwordTitle, null,
                  Appconstant.passwordValidationMessage, passwordFocus),
              _buildInputFieldLayout(
                  Appconstant.confirmPasswordTitle,
                  null,
                  Appconstant.confirmPasswordValidationMessage,
                  Icon(Icons.lock),
                  true,
                  _confirmPasswordChanged,
                  _validateConfirmPassword),
              _buildSignUpButton(),
            ],
          )),
        ]));
  }

  Widget _buildSignUpButton() {
    return Container(
        color: Colors.transparent,
        height: 50,
        width: 140,
        child: FlatButton(
          color: Appconstant.greenColor,
          textColor: Appconstant.appCheckoutPaymentTextColor,
          child: Text(Appconstant.signUpText,
              style: AppStyle.checkoutButtonFontContentFontStyle),
          onPressed: () {
            _completeSignUp();
          },
        ));
  }

  Widget _buildInputFieldLayout(
      String title,
      String initialValueTextData,
      String validationMessage,
      Icon targetIcon,
      bool obscureText,
      Function(String) onTextChanged,
      Function(String) onValidator) {
    return Ink(
      child: ListTile(
          subtitle: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                obscureText: obscureText,
                initialValue: initialValueTextData,
                onChanged: onTextChanged,
                cursorColor: Appconstant.greenColor,
                decoration: InputDecoration(
                    hintText: title, labelText: title, icon: targetIcon),
                validator: onValidator,
              ))),
      color: Appconstant.allWhite,
    );
  }

  Widget _buildPasswordInputFieldLayout(
      String title,
      String initialValueTextData,
      String validationMessage,
      FocusNode focusNode) {
    return Ink(
      child: ListTile(
          subtitle: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: PasswordField(
          focusNode: focusNode,
          fieldKey: _passwordFieldKey,
          helperText: title,
          labelText: title,
          onFieldSubmitted: (value) {},
        ),
      )),
      color: Appconstant.allWhite,
    );
  }

  String _completeSignUp() {
    var password = _passwordFieldKey.currentState;
    if (password.value == null && password.value.isNotEmpty) {
      return Appconstant.enterValidPasswordMessage;
    }
    if (password.value != userSignUp.password) {
      _formKey.currentState.validate();
      passwordFocus.requestFocus();
    }
    return null;
  }

  void _usernameChanged(String value) {
    userSignUp.username = value;
  }

  void _emailChanged(String value) {
    userSignUp.email = value;
  }

  void _confirmPasswordChanged(String value) {
    userSignUp.password = value;
  }

  String _validateEmptyValueWidget(String value) {
    if (value.isEmpty) {
      return Appconstant.provideValidValueMessage;
    }
    return null;
  }

  String _validateConfirmPassword(String value) {
    var password = _passwordFieldKey.currentState;
    if (password.value != userSignUp.password) {
      return Appconstant.ensurePasswordAreTheSameMessage;
    }
    return null;
  }
}
