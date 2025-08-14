import 'dart:io';

import 'package:calculator/app/product/component/record_button/controller/record_button_controller.dart';
import 'package:calculator/app/product/state/base/cubit/widget/base_cubit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RecordButtonWidget extends StatelessWidget {
  const RecordButtonWidget({
    super.key,
    required this.onResult,
  });

  final void Function(File)? onResult;

  @override
  Widget build(BuildContext context) {
    final controller = RecordButtonController(
      onResult,
    );
    return BlocProvider(
      create: (_) => controller,
      child: BaseCubitWidget(
        bloc: controller,
        initial: (state) {
          final isListening = state.model?.isListening ?? false;
          return FloatingActionButton(
            onPressed: () {
              isListening
                  ? controller.stopListening()
                  : controller.startListening();
            },
            backgroundColor: isListening ? Colors.red : Colors.blue,
            child: Icon(
              isListening ? Icons.stop : Icons.mic,
            ),
          );
        },
      ),
    );
  }
}
