import 'package:calculator/app/product/model/calculations/base_formula_model.dart';
import 'package:equatable/equatable.dart';

class FormulaModel with EquatableMixin {
  FormulaModel({
    required this.title,
    this.message,
    this.formulaType,
    this.gptEndpoint,
  });

  final String title;
  final String? message;
  final BaseFormulaModel? formulaType;
  final String? gptEndpoint;

  @override
  List<Object?> get props => [
        title,
        message,
        gptEndpoint,
        formulaType,
      ];

  FormulaModel copyWith({
    String? title,
    String? message,
    BaseFormulaModel? formulaType,
    String? gptEndpoint,
  }) =>
      FormulaModel(
        title: title ?? this.title,
        message: message ?? this.message,
        gptEndpoint: gptEndpoint ?? this.gptEndpoint,
        formulaType: formulaType ?? this.formulaType,
      );
}
