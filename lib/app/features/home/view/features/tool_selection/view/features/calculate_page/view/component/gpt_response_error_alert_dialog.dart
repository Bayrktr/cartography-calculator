import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/exception/gpt_response_exceptions.dart';
import 'package:flutter/material.dart';

class GptResponseErrorAlertDialog {
  const GptResponseErrorAlertDialog({
    required this.exception,
  });

  final GptResponseExceptions? exception;

  Widget get build {
    print(exception);
    switch (exception) {
      case GptResponseNoneException():
        return const AlertDialog();
      case GptResponseMissingValueException():
        final e = exception! as GptResponseMissingValueException;
        return AlertDialog(
          title: Text(
            e.message ?? '',
          ),
        );
      case GptResponseNoneKnownException():
        return const AlertDialog();
      case null:
        return const AlertDialog();
    }
  }
}
