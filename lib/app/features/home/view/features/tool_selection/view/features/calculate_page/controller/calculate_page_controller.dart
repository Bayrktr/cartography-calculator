import 'dart:io';
import 'package:base_cubit_widget/base_cubit_widget.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_repository.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_error_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_gpt_response_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_initial_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_show_modal_bottom_sheet_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/exception/gpt_response_exceptions.dart';
import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:dio/dio.dart';

class CalculatePageController extends BaseCubit<
    CalculatePageInitialModel,
    CalculatePageErrorModel,
    Object> {
  CalculatePageController({required this.formula}) : super(BaseState.loading());

  final FormulaModel formula;

  final CalculatePageRepository _repository = CalculatePageRepository();

  @override
  Future<void> onInit() async {
    emit(
      BaseState.initial(
        data: BaseInitialDataModel<CalculatePageInitialModel>(
          data: CalculatePageInitialModel(
            formula: formula,
          ),
        ),
      ),
    );
  }

  Future<void> getGptResult(File? voiceMessage) async {
    try {
      final formulaType = initialData?.data?.formula?.formulaType;

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

      emit(
        BaseState.initial(
          data: initialData!.copyWith(
            data: initialModel!.copyWith(
              gptResponseStatus: const CalculatePageGptResponseOnProgress(),
            ),
          ),
        ),
      );

      final response = await _repository.getGptResult(
        formulaType,
        formData,
      );

      final status = response.data?.status;

      resetGptResponse();

      if (status != 200) {
        emit(
          BaseState.initial(
            data: initialData!.copyWith(
              data: initialModel!.copyWith(
                gptResponseStatus: CalculatePageGptResponseError(
                  exception: GptResponseExceptions.fromType(
                    status,
                    response.data?.errors ?? [],
                    response.data?.message,
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        print('veriables');
        print(response.data!.variables);
        emit(
          BaseState.initial(
            data: initialData!.copyWith(
              data: initialModel!.copyWith(
                response: response.data,
                gptResponseStatus: CalculatePageGptResponseDone(
                  response: response.data,
                ),
              ),
            ),
          ),
        );
        emit(
          BaseState.initial(
            data: initialData!.copyWith(
              data: initialModel!.copyWith(
                modalSheet: const CalculatePageResultShowModalBottomSheet(),
              ),
            ),
          ),
        );
        resetModalSheet();
      }
      resetGptResponse();
    } on FormulaException catch (e) {
      switch (e) {
        case SomethingMissingException():
        case NoneFormulaException():
        case NoneKnownFormulaException():
      }
    } catch (e) {}
    resetModalSheet();
  }

  void updateVeriable(VeriableTypes<dynamic> veriable) {
    final veriables = formula.formulaType!.veriables!.veriableList; // fixme
    for (final x in veriables) {
      if (x!.veriableName == veriable.veriableName) {
        print('veriable guncelleniyo');

        emit(
          BaseState.initial(
            data: initialData!.copyWith(
              data: initialModel!.copyWith(
                formula: initialModel!.formula!.copyWith(
                  formulaType: initialModel!.formula!.formulaType!.copyWith(
                    veriables: initialModel!.formula!.formulaType!.veriables!
                        .updateVeriable(
                      veriable,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        for(var x in initialModel!.formula!.formulaType!.veriables!.veriableList){
          print(x!.value);
        }
      }
    }
  }

  void updateVeriableValue(String? name, double? value) {
    final veriables = formula.formulaType!.veriables!.veriableList; // fixme
    for (final x in veriables) {
      emit(
        BaseState.initial(
          data: initialData!.copyWith(
            data: initialModel!.copyWith(
              formula: initialModel!.formula!.copyWith(
                formulaType: initialModel!.formula!.formulaType!.copyWith(
                  veriables: initialModel!.formula!.formulaType!.veriables!
                      .updateVariableValue(name, value),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void updateResult() {
    try {
      initialModel!.formula!.formulaType!.calculate();

      emit(
        BaseState.initial(
          data: initialData!.copyWith(
            data: initialModel!.copyWith(
              modalSheet: const CalculatePageResultShowModalBottomSheet(),
            ),
          ),
        ),
      );
      resetModalSheet();
    } on FormulaException catch (e) {
      switch (e) {
        case SomethingMissingException():
          emit(
            BaseState.initial(
              data: initialData!.copyWith(
                data: initialModel!.copyWith(
                  formulaException: e,
                ),
              ),
            ),
          );
        case NoneFormulaException():
        case NoneKnownFormulaException():
          emit(
            BaseState.initial(
              data: initialData!.copyWith(
                data: initialModel!.copyWith(
                  formulaException: e,
                ),
              ),
            ),
          );
      }
    } catch (e) {}
    resetFormulaException();
  }

  void resetModalSheet() {
    emit(
      BaseState.initial(
        data: initialData!.copyWith(
          data: initialModel!.copyWith(
            modalSheet: const CalculatePageNoneShowModalBottomSheet(),
          ),
        ),
      ),
    );
  }

  void resetFormulaException() {
    emit(
      BaseState.initial(
        data: initialData!.copyWith(
          data: initialModel!.copyWith(
            formulaException: const NoneFormulaException(),
          ),
        ),
      ),
    );
  }

  void resetGptResponse() {
    print('resetlendi');
    emit(
      BaseState.initial(
        data: initialData!.copyWith(
          data: initialModel!.copyWith(
            gptResponseStatus: const CalculatePageGptResponseNone(),
          ),
        ),
      ),
    );
  }
}
