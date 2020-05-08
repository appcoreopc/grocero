import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationDialog extends StatelessWidget {

  String title; 
  String content;

  LocationDialog(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.content),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
