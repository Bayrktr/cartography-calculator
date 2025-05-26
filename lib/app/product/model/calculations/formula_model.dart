import 'package:calculator/app/product/model/calculations/veriable_types.dart';
import 'package:equatable/equatable.dart';

class FormulaModel with EquatableMixin {
  FormulaModel({
    required this.title,
    this.message,
    required this.veriables,
    required this.calculations,
    this.gptEndpoint,
  });

  final String title;
  final String? message;
  final List<VeriableTypes<dynamic>> veriables;
  final double Function(List<VeriableTypes<dynamic>> inputs) calculations;
  final String? gptEndpoint;

  @override
  List<Object?> get props => [
        title,
        message,
        veriables,
        calculations,
        gptEndpoint,
      ];
}
