import 'package:auto_route/annotations.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CalculatePageView extends StatelessWidget {
  CalculatePageView({super.key, this.formula});

  final FormulaModel? formula;

  @override
  Widget build(BuildContext context) {
    if (formula == null) return const SizedBox();

    return const Placeholder();
  }
}
