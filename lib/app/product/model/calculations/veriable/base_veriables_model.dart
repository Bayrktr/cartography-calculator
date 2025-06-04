import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';

abstract class BaseVeriablesModel{
  List<VeriableTypes<dynamic>?> get veriableList;

  BaseVeriablesModel  updateVeriable(VeriableTypes<dynamic> veriable);
}