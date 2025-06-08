import 'package:flutter/material.dart';

class CustomAlertDialog {
  CustomAlertDialog({
    required this.context,
    required this.builder,
  });

  final BuildContext context;
  final Widget builder;

  void get show {
    showDialog(
      context: context,
      builder: (context) {
        return builder;
      },
    );
  }
}
