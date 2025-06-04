sealed class FormulaException {
  String? get message;
}

class SomethingMissingException  implements FormulaException {
  SomethingMissingException({this.message});

  final String? message;
}
