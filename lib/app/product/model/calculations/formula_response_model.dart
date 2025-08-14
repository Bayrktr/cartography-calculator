import 'package:calculator/app/product/service/model/base_model.dart';
import 'package:equatable/equatable.dart';

class FormulaResponseModel extends BaseModel<FormulaResponseModel>
    with EquatableMixin {
  FormulaResponseModel({
    this.status,
    this.message,
    this.variables,
    this.result,
    this.errors,
  });

  final int? status;
  final String? message;
  final Map<String, double>? variables;
  final double? result;
  final List<Map<String, dynamic>?>? errors;

  @override
  List<Object?> get props => [
        status,
        message,
        variables,
        result,
        errors,
      ];

  FormulaResponseModel copyWith({
    int? status,
    String? message,
    Map<String, double>? variables,
    double? result,
    List<Map<String, dynamic>?>? errors,
  }) {
    return FormulaResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      variables: variables ?? this.variables,
      result: result ?? this.result,
      errors: errors ?? this.errors,
    );
  }

  @override
  FormulaResponseModel fromJson(Map<String, dynamic> json) {
    return FormulaResponseModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      variables: (json['variables'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, (value as num).toDouble()),
      ),
      result: (json['result'] as num?)?.toDouble(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>?)
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'variables': variables,
      'result': result,
      'errors': errors,
    };
  }
}
