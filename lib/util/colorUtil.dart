import 'package:flutter/material.dart';

class ColorUtil 
{ 
  static Color hexcolor(String code) 
  {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
