import 'dart:io';
import 'package:base_cubit_widget/base_cubit_widget.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_repository.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_error_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_gpt_response_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_initial_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_result_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/exception/gpt_response_exceptions.dart';
import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:calculator/app/product/model/calculations/base_formula_model.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:dio/dio.dart';

class CalculatePageController<
        T extends BaseFormulaModel<VeriableTypes<dynamic>>>
    extends BaseCubit<CalculatePageInitialModel, CalculatePageErrorModel,
        Object> {
  CalculatePageController({required this.formula}) : super(BaseState.loading());

  final FormulaModel<T> formula;

  final CalculatePageRepository _repository = CalculatePageRepository();

  @override
  Future<void> onInit() async {
    emit(BaseState.initial(
      data: BaseInitialDataModel<CalculatePageInitialModel>(
        data: CalculatePageInitialModel(),
      ),
    ));
  }

  Future<void> getGptResult(File? voiceMessage) async {
    try {
      final formulaType = formula.formulaType;

      if (formulaType == null || voiceMessage == null) {
        throw Exception();
      }

      final formData = FormData.fromMap(
        {
          'file': await MultipartFile.fromFile(
            voiceMessage.path,
            filename: voiceMessage.path.split('/').last,
          ),
        },
      );

      emitInitial(
        initialModel!.copyWith(
          gptResponseStatus: const CalculatePageGptResponseOnProgress(),
        ),
      );

      final response = await _repository.getGptResult(
        formulaType,
        formData,
      );

      final status = response.data?.status;

      resetGptResponse();

      if (status != 200) {
        emitInitial(
          initialModel!.copyWith(
            gptResponseStatus: CalculatePageGptResponseError(
              exception: GptResponseExceptions.fromType(
                status,
                response.data?.errors ?? [],
                response.data?.message,
              ),
            ),
          ),
        );
      } else {
        emitInitial(
          initialModel!.copyWith(
            gptResponseStatus: CalculatePageGptResponseDone(
              response: response.data,
            ),
          ),
        );
      }
      resetGptResponse();
    } on FormulaException catch (e) {
      switch (e) {
        case SomethingMissingException():
        case NoneFormulaException():
        case NoneKnownFormulaException():
      }
    } catch (e) {}
  }

  void updateResult(
    Map<String, VeriableTypes<dynamic>> updatedVeriables,
  ) {
    try {
      final value = formula.formulaType!.calculate(
        updatedVeriables,
      );
      emitInitial(
        initialModel!.copyWith(
          calculateResultStatus: CalculateResultDone<VeriableTypes<dynamic>>(
            value: value,
          ),
        ),
      );
    } on FormulaException catch (e) {
      print('hata yakalandı: $e');
      switch (e) {
        case SomethingMissingException():
          print(e.missingValues);
          emitInitial(
            initialModel!.copyWith(
              calculateResultStatus: CalculateResultError(
                exception: e,
              ),
            ),
          );
        case NoneFormulaException():
        case NoneKnownFormulaException():
          emitInitial(
            initialModel!.copyWith(
              calculateResultStatus: CalculateResultError(
                exception: e,
              ),
            ),
          );
      }
    } catch (e) {
      print(e);
    }
  }

  void resetGptResponse() {
    emitInitial(
      initialModel!.copyWith(
        gptResponseStatus: const CalculatePageGptResponseNone(),
      ),
    );
  }
}
