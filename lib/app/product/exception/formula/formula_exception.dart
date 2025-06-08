import 'package:calculator/app/core/extention/string/string_extention.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:calculator/generated/locale_keys.g.dart';

sealed class FormulaException {
  String? get message;
}

class NoneFormulaException implements FormulaException {
  const NoneFormulaException();

  @override
  String? get message => null;
}

class SomethingMissingException implements FormulaException {
  SomethingMissingException({this.missingValues});

  final List<VeriableTypes<dynamic>?>? missingValues;

  @override
  String? get message {
    final values = missingValues ?? [];
    final missingNames =
        values.where((v) => v != null).map((v) => v!.veriableName).join(', ');

    return LocaleKeys.exceptions_the_following_data_missing.lang.trWithArg(
      args: [missingNames],
    );
  }
}

class NoneKnownFormulaException implements FormulaException {
  @override
  String? get message => 'Something wrong';
}
