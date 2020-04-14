import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastView {

  static void show(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}