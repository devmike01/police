import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext{
  void showSnackbar(Widget content){
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: content));
  }
}