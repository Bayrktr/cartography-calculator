import 'package:calculator/app/product/service/model/base_model.dart';
import 'package:equatable/equatable.dart';

class GptResponse422ErrorModel extends BaseModel<GptResponse422ErrorModel>
    with EquatableMixin {
  GptResponse422ErrorModel({
    this.veriable,
    this.errorType,
    this.description,
  });

  final String? veriable;
  final String? errorType;
  final String? description;

  @override
  List<Object?> get props => [
        veriable,
        errorType,
        description,
      ];

  GptResponse422ErrorModel copyWith({
    String? veriable,
    String? errorType,
    String? description,
  }) {
    return GptResponse422ErrorModel(
      veriable: veriable ?? this.veriable,
      errorType: errorType ?? this.errorType,
      description: description ?? this.description,
    );
  }

  @override
  GptResponse422ErrorModel fromJson(Map<String, dynamic> json) {
    return GptResponse422ErrorModel(
      veriable: json['veriable'] as String?,
      errorType: json['error_type'] as String?,
      description: json['description'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
