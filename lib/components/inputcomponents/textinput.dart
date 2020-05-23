import 'package:flutter/material.dart';



  // ValueChanged<String> onChanged,
  //   GestureTapCallback onTap,
  //   VoidCallback onEditingComplete,
  //   ValueChanged<String> onFieldSubmitted,
  //   FormFieldSetter<String> onSaved,
  //   FormFieldValidator<String> validator,
  //   List<TextInputFormatter> inputFormatters,

class TextComponent extends StatelessWidget {
  
  TextComponent(
      {this.hintText, this.labelText, this.initialValueText});
  String hintText; 
  String labelText; 
  String initialValueText; 
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: this.initialValueText,
      cursorColor: Theme.of(context).cursorColor,
      decoration: InputDecoration(hintText: hintText, labelText: labelText),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}