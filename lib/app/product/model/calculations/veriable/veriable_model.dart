import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';

abstract class VeriableModel {
  String get veriableName;
  VeriableTypes<dynamic> get veriableValue;

}
