import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomModalBottomSheet {
  CustomModalBottomSheet({
    required this.context,
    required this.builder,
    this.backgroundColor,
  });

  final BuildContext context;
  final Widget builder;
  final Color? backgroundColor;

  void get show {
    showModalBottomSheet(
      backgroundColor: backgroundColor,
      context: context,
      builder: (_) {
        return builder;
      },
    );
  }
}
