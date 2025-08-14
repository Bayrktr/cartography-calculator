import 'package:calculator/app/core/extention/string/string_extention.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/model/exception/gpt_response_422_error_model.dart';
import 'package:calculator/generated/locale_keys.g.dart';

sealed class GptResponseExceptions {
  const GptResponseExceptions();

  factory GptResponseExceptions.fromType(
    int? statusCode,
    List<Map<String, dynamic>?> errors,
    String? message,
  ) {
    switch (statusCode) {
      case 422:
        return GptResponseMissingValueException(
          errors,
          message,
        );
      default:
        return GptResponseNoneKnownException();
    }
  }
}

class GptResponseNoneException extends GptResponseExceptions {}

class GptResponseMissingValueException extends GptResponseExceptions {
  GptResponseMissingValueException(this._errors, this._message);

  final String? _message;

  final List<Map<String, dynamic>?> _errors;

  String? get message => _message;

  List<GptResponse422ErrorModel> get missingVeriables {
    return _errors
        .whereType<Map<String, dynamic>>()
        .map(
          (e) => GptResponse422ErrorModel().fromJson(e),
        )
        .toList();
  }
}

class GptResponseNoneKnownException extends GptResponseExceptions {
  const GptResponseNoneKnownException();

  String get message => LocaleKeys.exceptions_error_with_unknown_cause.lang.tr;
}
