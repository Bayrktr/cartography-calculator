import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:flutter/material.dart';

class CalculateExceptionAlertDialog {
  const CalculateExceptionAlertDialog({
    required this.formulaException,
  });

  final FormulaException formulaException;

  Widget get build {
    return AlertDialog(
      title: Text(
        formulaException.message ?? '',
      ),
    );
  }
}
