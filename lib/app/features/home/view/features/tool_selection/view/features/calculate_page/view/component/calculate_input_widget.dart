import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/core/extention/string/string_extention.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/controller/calculate_page_controller.dart';
import 'package:calculator/app/product/constant/regexp/regexp_constant.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'distance_text_field.dart';

part 'degree_text_field.dart';

class CalculateInputWidget extends StatelessWidget {
  CalculateInputWidget({
    super.key,
    required this.veriable,
  });

  final VeriableTypes<dynamic> veriable;

  @override
  Widget build(BuildContext context) {
    switch (veriable) {
      case DistanceVeriable():
        return _DistanceTextField(
          veriable: veriable,
        );

      case DegreeVeriable():
        return _DegreeTextField(
          veriable: veriable,
        );
    }
  }
}
