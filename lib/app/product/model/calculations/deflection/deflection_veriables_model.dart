import 'package:calculator/app/core/extention/string/string_extention.dart';
import 'package:calculator/app/product/model/calculations/veriable/base_veriables_model.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';

class DeflectionVeriablesModel
    with EquatableMixin
    implements BaseVeriablesModel {
  DeflectionVeriablesModel({
    this.F,
    this.T,
    this.A,
    this.b,
  });

  final DistanceVeriable? F;
  final DistanceVeriable? T;
  final DistanceVeriable? A;
  final DegreeVeriable? b;

  @override
  List<Object?> get props => [
        F,
        T,
        A,
        b,
      ];

  factory DeflectionVeriablesModel.fromJson(Map<String, double> json) {
    return DeflectionVeriablesModel(
      F: DistanceVeriable(
        veriableName: 'F',
        value: (json['F'] as num?)?.toDouble(),
        title: LocaleKeys.deflection_fTitle.lang.tr,
      ),
      T: DistanceVeriable(
        veriableName: 'T',
        value: (json['T'] as num?)?.toDouble(),
        title: LocaleKeys.deflection_tTitle.lang.tr,

      ),
      A: DistanceVeriable(
        veriableName: 'A',
        value: (json['A'] as num?)?.toDouble(),
        title: LocaleKeys.deflection_aTitle.lang.tr,

      ),
      b: DegreeVeriable(
        veriableName: 'b',
        value: (json['b'] as num?)?.toDouble(),
        title: LocaleKeys.deflection_bTitle.lang.tr,

      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'F': F,
        'T': T,
        'A': A,
        'b': b,
      };

  DeflectionVeriablesModel copyWith({
    DistanceVeriable? F,
    DistanceVeriable? T,
    DistanceVeriable? A,
    DegreeVeriable? b,
  }) =>
      DeflectionVeriablesModel(
        F: F ?? this.F,
        T: T ?? this.T,
        A: A ?? this.A,
        b: b ?? this.b,
      );

  List<VeriableTypes<dynamic>?> get veriableList => [
        F,
        T,
        A,
        b,
      ];

  @override
  BaseVeriablesModel updateVeriable(
    VeriableTypes<dynamic> veriable,
  ) {
    switch (veriable.veriableName) {
      case 'F':
        return copyWith(F: veriable as DistanceVeriable);
      case 'T':
        return copyWith(T: veriable as DistanceVeriable);
      case 'A':
        return copyWith(A: veriable as DistanceVeriable);
      case 'b':
        return copyWith(b: veriable as DegreeVeriable);
      default:
        return this;
    }
  }
}
