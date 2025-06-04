import 'package:auto_route/annotations.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_controller.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/component/calculate_input_widget.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/state/base/cubit/widget/base_cubit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocProvider(
      create: (_) => controller,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            formula?.title ?? '',
            style: context.theme.textTheme.titleLarge,
          ),
        ),
        body: BaseCubitWidget(
          bloc: controller,
          initial: (state) {
            return ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount:
                  formula?.formulaType?.veriables?.veriableList.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final veriable =
                    formula?.formulaType?.veriables?.veriableList[index];
                print(formula?.formulaType?.veriables?.veriableList ?? 0);
                if (veriable == null) return Container();

                return CalculateInputWidget(
                  veriable: veriable,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
