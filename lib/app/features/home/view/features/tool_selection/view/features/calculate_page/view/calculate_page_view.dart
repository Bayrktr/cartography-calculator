import 'package:auto_route/annotations.dart';
import 'package:base_cubit_widget/base_cubit_widget.dart';
import 'package:base_cubit_widget/package/cubit/widget/base_cubit_widget.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_controller.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_error_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_gpt_response_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_initial_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_show_modal_bottom_sheet_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_result_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/exception/gpt_response_exceptions.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/calculate_result_modal_bottom_sheet.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/gpt_response_error_alert_dialog.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/input_widget/calculate_input_widget.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/input_widget/calculate_input_widget_controller.dart';
import 'package:calculator/app/product/component/alert_dialog/custom_alert_dialog.dart';
import 'package:calculator/app/product/component/loading/general_circular_progress.dart';
import 'package:calculator/app/product/component/modal_bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:calculator/app/product/component/record_button/view/record_button_widget.dart';
import 'package:calculator/app/product/component/scaffold/general_scaffold.dart';
import 'package:calculator/app/product/component/snack_bar/general_snack_bar.dart';
import 'package:calculator/app/product/component/text/locale_text.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'component/calculate_button.dart';

@RoutePage()
class CalculatePageView extends StatefulWidget {
  const CalculatePageView({super.key, this.formula});

  final FormulaModel? formula;

  @override
  State<CalculatePageView> createState() => _CalculatePageViewState();
}

class _CalculatePageViewState extends State<CalculatePageView> {
  late final CalculatePageController controller;
  late final Map<String, CalculateInputWidgetController> inputControllers;
  late final List<VeriableTypes<dynamic>> variables;

  @override
  void initState() {
    super.initState();

    final formula = widget.formula;
    if (formula == null) {
      variables = [];
      inputControllers = {};
      return;
    }

    variables = formula.formulaType?.veriables?.veriableList
            .whereType<VeriableTypes<dynamic>>()
            .toList() ??
        [];

    inputControllers = {
      for (final variable in variables)
        variable.veriableName:
            CalculateInputWidgetController<VeriableTypes<dynamic>>(variable),
    };

    controller = CalculatePageController(formula: formula);
  }

  @override
  void dispose() {
    for (final ctrl in inputControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.formula == null) return const SizedBox();

    return BlocProvider(
      create: (_) => controller,
      child: BaseCubitWidget(
        bloc: controller,
        blocType: BlocType.both,
        initialListener: _listener,
        initialBuilder: (state) {
          final data = state.model!;
          final gptStatus = data.gptResponseStatus;

          return GeneralScaffold(
            isLoading: gptStatus is CalculatePageGptResponseOnProgress,
            appBar: AppBar(
              title: Text(
                widget.formula?.title ?? '',
                style: context.theme.textTheme.titleLarge,
              ),
            ),
            floatingActionButton: RecordButtonWidget(
              onResult: controller.getGptResult,
            ),
            body: Padding(
              padding: context.padding.normal,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: variables.length + 1,
                itemBuilder: (context, index) {
                  if (index == variables.length) {
                    return _CalculateButton(
                      onPressed: () {
                        controller.updateResult(
                          _getUpdatedVeriables(),
                        );
                      },
                    );
                  }

                  final variable = variables[index];
                  final fieldController =
                      inputControllers[variable.veriableName]!;

                  return CalculateInputWidget(
                    veriable: variable,
                    controller: fieldController,
                    onChanged: (text) {},
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _listener(
      BuildContext context,
      BaseInitialModel<CalculatePageInitialModel, CalculatePageErrorModel,
              Object>
          state) {
    final data = state.model!;
    final gptResponse = data.gptResponseStatus;
    final calcResult = data.calculateResultStatus;

    switch (calcResult) {
      case CalculateResultDone<VeriableTypes>():
        final doneData = calcResult.value;
        print('aaa');
        GeneralSnackBar.show(
          context: context,
          title: 'Başarılı',
          message: doneData?.unit ?? '',
          type: GeneralSnackBarType.success,
        );
      case CalculateResultError():
        GeneralSnackBar.show(
          context: context,
          title: 'Hata',
          message: 'Hesaplama başarısız',
          type: GeneralSnackBarType.error,
        );
      default:
        break;
    }

    switch (gptResponse) {
      case CalculatePageGptResponseDone():
        final doneData = gptResponse.response;
      case CalculatePageGptResponseError():
        GeneralSnackBar.show(
          context: context,
          title: 'GPT Hatası',
          message: 'Yanıt alınamadı',
          type: GeneralSnackBarType.error,
        );
      default:
        break;
    }
  }

  Map<String, VeriableTypes<dynamic>> _getUpdatedVeriables() {
    final updatedVeriables = <String, VeriableTypes<dynamic>>{};

    inputControllers.forEach((key, controller) {
      final value = controller.veriable;
      updatedVeriables[key] = value;
    });

    return updatedVeriables;
  }
}
