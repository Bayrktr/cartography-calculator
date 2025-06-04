import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/model/calculations/formula_response_model.dart';
import 'package:equatable/equatable.dart';

class CalculatePageInitialModel with EquatableMixin {
  CalculatePageInitialModel({
    this.response,
    this.formula,
  });

  final FormulaResponseModel? response;
  final FormulaModel? formula;

  @override
  List<Object?> get props => [
        response,
        formula,
      ];

  CalculatePageInitialModel copyWith({
    FormulaResponseModel? response,
    FormulaModel? formula,
  }) =>
      CalculatePageInitialModel(
        response: response ?? this.response,
        formula: formula ?? this.formula,
      );
}
