import 'dart:math';

import 'package:calculator/app/core/extention/string/string_extention.dart';
import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:calculator/app/product/model/calculations/deflection/deflection_veriables_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/base_veriables_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';

sealed class BaseFormulaModel<T extends VeriableTypes<dynamic>> {
  T calculate(Map<String, VeriableTypes<dynamic>> veriables);

  BaseVeriablesModel? veriables;

  BaseFormulaModel copyWith({BaseVeriablesModel? veriables});
}

class DeflectionFormula extends BaseFormulaModel<DegreeVeriable>
    with EquatableMixin {
  DeflectionFormula({
    this.veriables,
  });

  final DeflectionVeriablesModel? veriables;

  DegreeVeriable get _result => DegreeVeriable(
        veriableName: 'x',
        title: LocaleKeys.deflection_xTitle.lang.tr,
      );

  @override
  DegreeVeriable calculate(
      Map<String, VeriableTypes<dynamic>> updatedVeriables) {
    final missing = <String>[];

    final tVar = updatedVeriables[veriables?.T?.veriableName];
    final fVar = updatedVeriables[veriables?.F?.veriableName];
    final aVar = updatedVeriables[veriables?.A?.veriableName];
    final bVar = updatedVeriables[veriables?.b?.veriableName];

    if (tVar?.value == null) missing.add('T');
    if (fVar?.value == null) missing.add('F');
    if (aVar?.value == null) missing.add('A');
    if (bVar?.value == null) missing.add('b');

    if (missing.isNotEmpty) {
      throw SomethingMissingException(
          missingValues: missing.map((e) => updatedVeriables[e]).toList());
    }

    final TValue = _toInt(tVar!.value);
    final FValue = _toInt(fVar!.value);
    final AValue = _toInt(aVar!.value);
    final bValue = _toInt(bVar!.value);

    final sqrtT = sqrt(TValue);
    final sqrtF = sqrt(FValue);

    final innerFraction = pow(sqrtT / (2 * sqrtF - 1), 2);
    final tanPart = tan((bValue - 100) * pi / 180);
    final total = (innerFraction / AValue) + tanPart;
    final alfa = atan(total) * 180 / pi + 100;

    return _result.copyWith(value: alfa);
  }

  int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed != null) return parsed.toInt();
    }
    throw Exception('Değer int veya double olmalı, gelen: $value');
  }


  @override
  List<Object?> get props => [veriables];

  @override
  DeflectionFormula copyWith({BaseVeriablesModel? veriables}) {
    return DeflectionFormula(
      veriables:
          veriables is DeflectionVeriablesModel ? veriables : this.veriables,
    );
  }
}
