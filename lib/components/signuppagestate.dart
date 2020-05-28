import 'package:flutter/material.dart';
import 'package:grocero/appconstant.dart';
import 'package:grocero/components/signupcomponent/signupcomponent.dart';
import 'appbar/appBarComponent.dart';

class SignUpPageState<T extends StatefulWidget> extends State<T> {
  SignUpPageState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
            child: Scaffold(
      appBar:
          AppBarComponent.createAppBarComponent(Appconstant.signUpPageTitle),
      body: SignUpComponent(context),
      backgroundColor: Appconstant.allWhite,
    )));
  }
}
