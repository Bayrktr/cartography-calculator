import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/exception/gpt_response_exceptions.dart';
import 'package:calculator/app/product/model/calculations/formula_response_model.dart';

sealed class CalculatePageGptResponseStatus {
  const CalculatePageGptResponseStatus();
}

class CalculatePageGptResponseNone extends CalculatePageGptResponseStatus {
  const CalculatePageGptResponseNone();
}

class CalculatePageGptResponseOnProgress
    extends CalculatePageGptResponseStatus {
  const CalculatePageGptResponseOnProgress();
}

class CalculatePageGptResponseError extends CalculatePageGptResponseStatus {
  CalculatePageGptResponseError({
    this.exception,
  });

  final GptResponseExceptions? exception;
}

class CalculatePageGptResponseDone extends CalculatePageGptResponseStatus {
  CalculatePageGptResponseDone({
    this.response,
  });

  final FormulaResponseModel? response;

}
