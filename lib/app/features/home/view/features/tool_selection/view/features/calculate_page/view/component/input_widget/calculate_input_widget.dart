import 'package:base_cubit_widget/base_cubit_widget.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/core/extention/string/string_extention.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_controller.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_gpt_response_status.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/calculate_page_initial_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../distance_text_field.dart';
part '../degree_text_field.dart';

class CalculateInputWidget extends StatelessWidget {
  const CalculateInputWidget({
    super.key,
    required this.veriable,
    required this.controller,
  });

  final VeriableTypes<dynamic> veriable;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalculatePageController,
        BaseState<CalculatePageInitialModel, Object, Object>>(
      listener: (context, state) {
        switch (state) {
          case BaseInitialModel<CalculatePageInitialModel, Object, Object>():
            final status = state.model?.gptResponseStatus;

            switch (status) {
              case CalculatePageGptResponseDone():
                final variables = status.response?.variables;
                final matchedValue = variables?[veriable.veriableName];

                if (matchedValue != null) {
                  context.read<CalculatePageController>().updateVeriableValue(
                        veriable.veriableName,
                        matchedValue,
                      );
                  controller.text = matchedValue.toString();
                }
                break;

              case CalculatePageGptResponseError():
              case CalculatePageGptResponseOnProgress():
              case CalculatePageGptResponseNone():
              case null:
                break;
            }

          case BaseLoadingModel<CalculatePageInitialModel, Object, Object>():
          case BaseErrorModel<CalculatePageInitialModel, Object, Object>():
        }
      },
      child: _getFormField(context),
    );
  }

  Widget _getFormField(BuildContext context) {
    switch (veriable) {
      case DistanceVeriable():
        return _DistanceTextField(
          veriable: veriable,
          controller: controller,
        );

      case DegreeVeriable():
        return _DegreeTextField(
          veriable: veriable,
          controller: controller,
        );
    }
  }
}
