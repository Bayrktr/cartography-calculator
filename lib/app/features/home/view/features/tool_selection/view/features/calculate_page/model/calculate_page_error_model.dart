import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:equatable/equatable.dart';

class CalculatePageErrorModel with EquatableMixin {
  CalculatePageErrorModel({
    this.formulaException,
    this.generalException,
  });

  final FormulaException? formulaException;
  final Exception? generalException;

  @override
  List<Object?> get props => [
        formulaException,
        generalException,
      ];

  CalculatePageErrorModel copyWith(
    FormulaException? formulaException,
    Exception? generalException,
  ) =>
      CalculatePageErrorModel(
        formulaException: formulaException ?? this.formulaException,
        generalException: generalException ?? this.generalException,
      );
}
