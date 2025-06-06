import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/product/component/text/locale_text.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_model.dart';
import 'package:flutter/material.dart';

class CalculateResultModalBottomSheet extends StatelessWidget {
  const CalculateResultModalBottomSheet({
    super.key,
    required this.veriable,
  });

  final VeriableModel veriable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.low,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Text(
            'Calculation Result',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          LocaleText(
            textAlign: TextAlign.center,
            textStyle: context.theme.textTheme.bodyMedium,
            text: '',
          ),
          Padding(
            padding: context.padding.low,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Dismiss',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
