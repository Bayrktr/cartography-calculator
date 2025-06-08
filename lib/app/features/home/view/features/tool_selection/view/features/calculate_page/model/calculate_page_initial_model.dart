import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_show_modal_bottom_sheet_model.dart';
import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/model/calculations/formula_response_model.dart';
import 'package:equatable/equatable.dart';

class CalculatePageInitialModel with EquatableMixin {
  CalculatePageInitialModel({
    this.response,
    this.formula,
    this.modalSheet = const CalculatePageNoneShowModalBottomSheet(),
    this.formulaException = const NoneFormulaException(),
    this.voiceMessage = '',
  });

  final FormulaResponseModel? response;
  final FormulaModel? formula;
  final CalculatePageShowModalBottomSheetModel modalSheet;
  final FormulaException formulaException;
  final String voiceMessage;

  @override
  List<Object?> get props => [
        response,
        formula,
        modalSheet,
        formulaException,
        voiceMessage,
      ];

  CalculatePageInitialModel copyWith({
    FormulaResponseModel? response,
    FormulaModel? formula,
    CalculatePageShowModalBottomSheetModel? modalSheet,
    FormulaException? formulaException,
    String? voiceMessage,
  }) =>
      CalculatePageInitialModel(
        response: response ?? this.response,
        formula: formula ?? this.formula,
        modalSheet: modalSheet ?? this.modalSheet,
        formulaException: formulaException ?? this.formulaException,
        voiceMessage: voiceMessage ?? this.voiceMessage,
      );
}
