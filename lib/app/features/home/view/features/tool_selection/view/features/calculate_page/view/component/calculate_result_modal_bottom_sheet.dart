import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/product/component/text/locale_text.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class CalculateResultModalBottomSheet extends StatelessWidget {
  const CalculateResultModalBottomSheet({
    super.key,
    required this.veriable,
  });

  final VeriableTypes<dynamic> veriable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.low,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: context.sized.widthHighValue,
            height: context.sized.dynamicHeight(0.005),
            margin: EdgeInsets.only(
              bottom: context.sized.heightNormalValue,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: context.borderRadius.low,
            ),
          ),
          LocaleText(
            text: LocaleKeys.calculation_calculation_result,
            textStyle: context.theme.textTheme.titleMedium,
          ),
          const Divider(),
          SizedBox(
            height: context.sized.heightNormalValue,
          ),
          Text(
            '${veriable.value} ${veriable.unit}',
            style: context.theme.textTheme.titleSmall,
          ),
          Padding(
            padding: context.padding.low,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: context.borderRadius.normal,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: context.sized.heightNormalValue,
                ),
              ),
              child: LocaleText(
                text: LocaleKeys.calculation_dismiss,
                textStyle: context.theme.textTheme.bodyLarge,
              ),
            ),
          ),
          SizedBox(
            height: context.sized.heightNormalValue,
          ),
        ],
      ),
    );
  }
}
