import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_repository.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_error_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_initial_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_show_modal_bottom_sheet_model.dart';
import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:calculator/app/product/state/base/cubit/base_cubit.dart';
import 'package:calculator/app/product/state/base/cubit/base_state.dart';
import 'package:calculator/app/product/state/base/cubit/model/initial/base_initial_data_model.dart';

class CalculatePageController extends BaseCubit<
    CalculatePageInitialModel,
    CalculatePageErrorModel,
    Object,
    BaseState<CalculatePageInitialModel, CalculatePageErrorModel, Object>> {
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

  Future<void> getGptResult(String? voiceMessage) async {
    try {
      final formulaType = initialData?.data?.formula?.formulaType;

      if (formulaType == null || voiceMessage == null) {
        throw SomethingMissingException(message: 'Gerekli veriler eksik.');
      }

      final data = {'text': voiceMessage};

      final response = await _repository.getGptResult(
        formulaType,
        data,
      );

      emit(
        BaseState.initial(
          data: initialData!.copyWith(
            data: initialModel!.copyWith(
              response: response.data,
            ),
          ),
        ),
      );
    } on FormulaException catch (e) {
      switch (e) {
        case SomethingMissingException():
      }
    } catch (e) {}
  }

  void updateVeriable(VeriableTypes<dynamic> veriable) {
    final veriables = formula.formulaType!.veriables!.veriableList; // fixme
    for (final x in veriables) {
      if (x!.veriableName == veriable.veriableName) {
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
      }
    }
  }

  void updateResult() {
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
}
