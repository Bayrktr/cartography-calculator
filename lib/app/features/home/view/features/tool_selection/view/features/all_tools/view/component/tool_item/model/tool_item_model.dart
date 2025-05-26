import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:equatable/equatable.dart';

class ToolItemModel with EquatableMixin {
  ToolItemModel({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.formula,
  });

  final String title;
  final String description;
  final String iconPath;
  final FormulaModel formula;

  @override
  List<Object?> get props => [
        title,
        description,
        formula,
      ];
}
