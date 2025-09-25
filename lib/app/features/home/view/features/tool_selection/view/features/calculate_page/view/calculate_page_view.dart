import 'package:auto_route/annotations.dart';
import 'package:base_cubit_widget/package/cubit/widget/base_cubit_widget.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_controller.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_gpt_response_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_show_modal_bottom_sheet_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/exception/gpt_response_exceptions.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/calculate_result_modal_bottom_sheet.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/gpt_response_error_alert_dialog.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/input_widget/calculate_input_widget.dart';
import 'package:calculator/app/product/component/alert_dialog/custom_alert_dialog.dart';
import 'package:calculator/app/product/component/loading/general_circular_progress.dart';
import 'package:calculator/app/product/component/modal_bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:calculator/app/product/component/record_button/view/record_button_widget.dart';
import 'package:calculator/app/product/component/scaffold/general_scaffold.dart';
import 'package:calculator/app/product/component/snack_bar/general_snack_bar.dart';
import 'package:calculator/app/product/component/text/locale_text.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
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
        if (variable != null) variable.veriableName: TextEditingController(),
    };

    return BlocProvider(
      create: (_) => controller,
      child: BaseCubitWidget(
        bloc: controller,
        blocType: BlocType.both,
        initialListener: (context, state) {
          final data = state.model!;
          final resultStatus = data.gptResponseStatus;
          switch (resultStatus) {
            case CalculatePageGptResponseNone():
              break;
            case CalculatePageGptResponseOnProgress():
              break;

            case CalculatePageGptResponseError():
              final errorData = resultStatus.exception;
              switch (errorData) {
                case null:
                  break;
                case GptResponseNoneException():
                  GeneralSnackBar.show(
                      context: context,
                      title: 'Başarısız',
                      message: '',
                      type: GeneralSnackBarType.error);

                case GptResponseMissingValueException():
                  GeneralSnackBar.show(
                      context: context,
                      title: 'Başarısız',
                      message: '',
                      type: GeneralSnackBarType.error);

                case GptResponseNoneKnownException():
                  GeneralSnackBar.show(
                      context: context,
                      title: 'Başarısız',
                      message: '',
                      type: GeneralSnackBarType.error);
              }

            case CalculatePageGptResponseDone():
              GeneralSnackBar.show(
                  context: context,
                  title: 'Başarılı',
                  message: '',
                  type: GeneralSnackBarType.success);
          }
        },
        initialBuilder: (state) {
          final data = state.model!;
          final resultStatus = data.gptResponseStatus;
          return GeneralScaffold(
            isLoading: resultStatus is CalculatePageGptResponseOnProgress,
            appBar: AppBar(
              title: Text(
                formula?.title ?? '',
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
          );
        },
      ),
    );
  }
}
