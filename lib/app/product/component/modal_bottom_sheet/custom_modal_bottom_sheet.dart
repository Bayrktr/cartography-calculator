import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomModalBottomSheet {
  CustomModalBottomSheet({required this.context, required this.builder});

  final BuildContext context;
  final Widget builder;

  void get show {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return builder;
      },
    );
  }
}
