import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/exception/gpt_response_exceptions.dart';
import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:calculator/app/product/model/calculations/base_formula_model.dart';
import 'package:calculator/app/product/model/calculations/formula_response_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';

sealed class CalculateResultStatus {
  const CalculateResultStatus();
}

class CalculateResultNone extends CalculateResultStatus {
  const CalculateResultNone();
}

class CalculateResultOnProgress extends CalculateResultStatus {
  const CalculateResultOnProgress();
}

class CalculateResultError extends CalculateResultStatus {
  CalculateResultError({
    this.exception = const NoneFormulaException(),
  });

  final FormulaException exception;
}

class CalculateResultDone<T extends VeriableTypes<dynamic>>
    extends CalculateResultStatus {
  CalculateResultDone({
    this.value,
  });

  final T? value;
}
