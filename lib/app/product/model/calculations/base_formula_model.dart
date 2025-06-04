import 'dart:math';

import 'package:calculator/app/core/extention/string/string_extention.dart';
import 'package:calculator/app/product/exception/formula/formula_exception.dart';
import 'package:calculator/app/product/model/calculations/deflection/deflection_veriables_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/base_veriables_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';

sealed class BaseFormulaModel {
  VeriableTypes<dynamic> get calculate;

  BaseVeriablesModel? veriables;

  BaseFormulaModel copyWith({BaseVeriablesModel? veriables});
}

class DeflectionFormula extends BaseFormulaModel with EquatableMixin {
  DeflectionFormula({
    this.veriables,
  });

  final DeflectionVeriablesModel? veriables;

  @override
  DegreeVeriable get calculate {
    for (final x in veriables?.veriableList ?? []) {
      switch (x) {
        case DistanceVeriable():
          if (x.value == null) {
            throw SomethingMissingException();
          }
        case DegreeVeriable():
          if (x.value == null) {
            throw SomethingMissingException();
          }
      }
    }

    final TValue = veriables!.T!.value!.toInt();
    final FValue = veriables!.F!.value!.toInt();
    final AValue = veriables!.A!.value!.toInt();
    final bValue = veriables!.b!.value!.toInt();

    final sqrtT = sqrt(
      TValue,
    );
    final sqrtF = sqrt(
      FValue,
    );

    final innerFraction = pow(sqrtT / (2 * sqrtF - 1), 2);
    final tanPart = tan((bValue - 100) * pi / 180);

    final total = (innerFraction / AValue) + tanPart;

    final alfa = atan(total) * 180 / pi + 100;

    return DegreeVeriable(
      veriableName: 'x',
      value: alfa,
      title: LocaleKeys.deflection_xTitle.lang.tr,
    );
  }

  @override
  List<Object?> get props => [
        veriables,
      ];

  @override
  DeflectionFormula copyWith({BaseVeriablesModel? veriables}) {
    return DeflectionFormula(
      veriables:
          veriables is DeflectionVeriablesModel ? veriables : this.veriables,
    );
  }
}
