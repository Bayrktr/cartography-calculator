
import 'package:auto_route/annotations.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_controller.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_error_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_gpt_response_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_initial_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_show_modal_bottom_sheet_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/calculate_exception_alert_dialog.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/calculate_result_modal_bottom_sheet.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/gpt_response_error_alert_dialog.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/input_widget/calculate_input_widget.dart';
import 'package:calculator/app/product/component/alert_dialog/custom_alert_dialog.dart';
import 'package:calculator/app/product/component/modal_bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:calculator/app/product/component/record_button/view/record_button_widget.dart';
import 'package:calculator/app/product/component/text/locale_text.dart';
import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/state/base/cubit/base_state.dart';
import 'package:calculator/app/product/state/base/cubit/widget/base_cubit_widget.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'component/calculate_button.dart';
@RoutePage()
class CalculatePageView extends StatelessWidget {
  CalculatePageView({super.key, this.formula});

  final FormulaModel? formula;

  @override
  Widget build(BuildContext context) {
    if (formula == null) return const SizedBox();

    final controller = CalculatePageController(formula: formula!);
    final variables = formula?.formulaType?.veriables?.veriableList ?? [];

    final textControllers = {
      for (final variable in variables)
        if (variable != null)
          variable.veriableName: TextEditingController(),
    };

    return BlocProvider(
      create: (_) => controller,
      child: BaseCubitWidget(
        bloc: controller,
        blocType: BlocType.both,
        listener: (context, state) {
          switch (state) {
            case BaseInitialModel():
              final model = state.model;
              if (model?.modalSheet is CalculatePageResultShowModalBottomSheet) {
                print('burası1');
                CustomModalBottomSheet(
                  backgroundColor: context.theme.bottomNavigationBarTheme.backgroundColor,
                  context: context,
                  builder: CalculateResultModalBottomSheet(
                    veriable: model!.formula!.formulaType!.result,
                  ),
                ).show;
              }

              /*

              if (model?.formulaException is FormulaException) {
                print('burası2');

                CustomAlertDialog(
                  context: context,
                  builder: CalculateExceptionAlertDialog(
                    formulaException: model!.formulaException,
                  ).build,
                ).show;
              }

               */

              if (model?.gptResponseStatus is CalculatePageGptResponseError) {
                print('burası3');

                CustomAlertDialog(
                  context: context,
                  builder: GptResponseErrorAlertDialog(
                    exception: (model?.gptResponseStatus as CalculatePageGptResponseError?)?.exception,
                  ).build,
                ).show;
              }
              break;

            default:
              break;
          }
        },
        initial: (state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(formula?.title ?? '', style: context.theme.textTheme.titleLarge),
            ),
            floatingActionButton: RecordButtonWidget(
              onResult: controller.getGptResult,
            ),
            body: Stack(
              children: [
                Padding(
                  padding: context.padding.normal,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: variables.length + 1,
                    itemBuilder: (context, index) {
                      if (index == variables.length) {
                        return const _CalculateButton();
                      }

                      final variable = variables[index];
                      if (variable == null) return const SizedBox.shrink();

                      return CalculateInputWidget(
                        veriable: variable,
                        controller: textControllers[variable.veriableName]!,
                      );
                    },
                  ),
                ),
                if (state.model?.gptResponseStatus is CalculatePageGptResponseOnProgress)
                  const _LoadingOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black.withOpacity(0.4),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
