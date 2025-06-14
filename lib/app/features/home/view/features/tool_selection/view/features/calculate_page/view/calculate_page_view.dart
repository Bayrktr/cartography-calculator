import 'package:auto_route/annotations.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_controller.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_error_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_initial_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_show_modal_bottom_sheet_model.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/calculate_exception_alert_dialog.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/calculate_result_modal_bottom_sheet.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/input_widget/calculate_input_widget.dart';
import 'package:calculator/app/product/component/alert_dialog/custom_alert_dialog.dart';
import 'package:calculator/app/product/component/modal_bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:calculator/app/product/component/record_button/record_button_widget.dart';
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
    final controller = CalculatePageController(
      formula: formula!,
    );

    final veriables = formula?.formulaType?.veriables?.veriableList ?? [];

    final length = veriables.length;

    return BlocProvider(
      create: (_) => controller,
      child: Scaffold(
        floatingActionButton: RecordButtonWidget(
          onResult: (String? value) {
            print('message : $value');
            controller.getGptResult(value);
          },
        ),
        appBar: AppBar(
          title: Text(
            formula?.title ?? '',
            style: context.theme.textTheme.titleLarge,
          ),
        ),
        body: BaseCubitWidget(
          bloc: controller,
          blocType: BlocType.both,
          initial: (state) {
            return Padding(
              padding: context.padding.normal,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == length) {
                    return const _CalculateButton();
                  }
                  final veriable = veriables[index];

                  if (veriable == null) return Container();

                  return CalculateInputWidget(
                    veriable: veriable,
                  );
                },
              ),
            );
          },
          listener: (context, state) {
            switch (state) {
              case BaseInitialModel<CalculatePageInitialModel,
                    CalculatePageErrorModel, Object>():
                switch (state.model?.modalSheet) {
                  case null:
                    break;
                  case CalculatePageNoneShowModalBottomSheet():
                    break;
                  case CalculatePageResultShowModalBottomSheet():
                    CustomModalBottomSheet(
                      backgroundColor: context
                          .theme.bottomNavigationBarTheme.backgroundColor,
                      context: context,
                      builder: CalculateResultModalBottomSheet(
                        veriable: state.model!.formula!.formulaType!.result,
                      ),
                    ).show;
                }

                switch (state.model?.formulaException) {
                  case null:
                    break;
                  case NoneFormulaException():
                    break;
                  case SomethingMissingException():
                    CustomAlertDialog(
                      context: context,
                      builder: CalculateExceptionAlertDialog(
                        formulaException: state.model!.formulaException,
                      ).build,
                    ).show;
                  case NoneKnownFormulaException():
                    CustomAlertDialog(
                      context: context,
                      builder: CalculateExceptionAlertDialog(
                        formulaException: state.model!.formulaException,
                      ).build,
                    ).show;
                }

              case BaseLoadingModel<CalculatePageInitialModel,
                    CalculatePageErrorModel, Object>():
              case BaseErrorModel<CalculatePageInitialModel,
                    CalculatePageErrorModel, Object>():
            }
          },
        ),
      ),
    );
  }
}
