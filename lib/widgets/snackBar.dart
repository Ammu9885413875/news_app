import 'package:flutter/material.dart';

class SnackBarWidget{
  showSnackBar(String msg, Color color,BuildContext context) {
    SnackBar mySnack = SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 1),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(mySnack);
  }
}
