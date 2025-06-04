import 'package:calculator/app/core/extention/string/string_extention.dart';
import 'package:calculator/generated/locale_keys.g.dart';

sealed class VeriableTypes<T> {
  String get title;

  String get veriableName;

  T? get value;

  String get unit;

  VeriableTypes<T> copyWith({String? veriableName, T? value});
}

class DistanceVeriable extends VeriableTypes<double> implements Type {
  DistanceVeriable({
    required this.veriableName,
    this.value,
    required this.title,
  });

  final String veriableName;
  final double? value;
  final String title;

  @override
  String get unit => LocaleKeys.units_meter.lang.tr;

  @override
  DistanceVeriable copyWith({
    String? veriableName,
    double? value,
    String? title,
  }) {
    return DistanceVeriable(
      veriableName: veriableName ?? this.veriableName,
      value: value ?? this.value,
      title: title ?? this.title,
    );
  }
}

class DegreeVeriable extends VeriableTypes<double> implements Type {
  DegreeVeriable({
    required this.veriableName,
    this.value,
    required this.title,
  });

  final double? value;

  final String veriableName;
  final String title;

  @override
  String get unit => LocaleKeys.units_degree.lang.tr;

  @override
  DegreeVeriable copyWith({
    String? veriableName,
    double? value,
    String? title,
  }) {
    return DegreeVeriable(
      veriableName: veriableName ?? this.veriableName,
      value: value ?? this.value,
      title: title ?? this.title,
    );
  }
}
