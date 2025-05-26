sealed class VeriableTypes<T> {
  String get veriableName;

  T get value;
}

class DoubleVeriable extends VeriableTypes<double> implements Type {
  DoubleVeriable({required this.veriableName, required this.value});

  final String veriableName;
  final double value;
}

class DegreeVeriable extends VeriableTypes<double> implements Type {
  DegreeVeriable({required this.veriableName, required this.value});

  final double value;

  final String veriableName;
}
