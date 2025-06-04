import 'package:calculator/app/product/service/model/base_model.dart';
import 'package:equatable/equatable.dart';

class FormulaResponseModel extends BaseModel<FormulaResponseModel>
    with EquatableMixin {
  FormulaResponseModel({
    this.message,
    this.veriables,
    this.result,
    this.errors,
  });

  final String? message;
  final Map<String, double>? veriables;
  final double? result;
  final List<dynamic>? errors;

  @override
  List<Object?> get props => [];

  FormulaResponseModel copyWith({
    String? message,
    Map<String, double>? veriables,
    double? result,
    List<dynamic>? errors,
  }) {
    return FormulaResponseModel(
      message: message ?? this.message,
      veriables: veriables ?? this.veriables,
      result: result ?? this.result,
      errors: errors ?? this.errors,
    );
  }

  @override
  FormulaResponseModel fromJson(Map<String, dynamic> json) {
    return FormulaResponseModel(
      message: json['message'] as String?,
      veriables: json['veriables'] as Map<String, double>,
      result: json['result'] as double?,
      errors: json['errors'] as List<dynamic>?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
