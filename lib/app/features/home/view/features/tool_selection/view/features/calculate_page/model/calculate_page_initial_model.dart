import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_gpt_response_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_show_modal_bottom_sheet_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_result_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/exception/gpt_response_exceptions.dart';
import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/model/calculations/formula_response_model.dart';
import 'package:equatable/equatable.dart';

class CalculatePageInitialModel with EquatableMixin {
  CalculatePageInitialModel({
    this.calculateResultStatus = const CalculateResultNone(),
    this.voiceMessage = '',
    this.gptResponseStatus = const CalculatePageGptResponseNone(),
  });

  final CalculateResultStatus calculateResultStatus;
  final String voiceMessage;
  final CalculatePageGptResponseStatus gptResponseStatus;

  @override
  List<Object?> get props => [
        calculateResultStatus,
        voiceMessage,
        gptResponseStatus,
      ];

  CalculatePageInitialModel copyWith({
    CalculateResultStatus? calculateResultStatus,
    String? voiceMessage,
    CalculatePageGptResponseStatus? gptResponseStatus,
  }) =>
      CalculatePageInitialModel(
        calculateResultStatus:
            calculateResultStatus ?? this.calculateResultStatus,
        voiceMessage: voiceMessage ?? this.voiceMessage,
        gptResponseStatus: gptResponseStatus ?? this.gptResponseStatus,
      );
}
