import 'package:flutter/material.dart';
import 'package:calculator/app/product/model/calculations/veriable/veriable_types.dart';

class CalculateInputWidgetController<T extends VeriableTypes<dynamic>>
    extends ChangeNotifier {
  CalculateInputWidgetController(T initialValue)
      : _veriable = initialValue,
        textController = TextEditingController(
          text: _formatValue(initialValue.value),
        );

  final TextEditingController textController;

  T _veriable;
  T get veriable => _veriable;

  /// TextField değiştiğinde çağrılır, input her zaman double olarak parse edilir
  void setFromText(String text) {
    if (text.isEmpty) return;

    final parsed = double.tryParse(text);
    if (parsed == null) return;

    _veriable = _veriable.copyWith(value: parsed) as T;

    // Gereksiz ".0" olmadan TextField güncelle
    textController.text = _formatValue(_veriable.value);

    notifyListeners();
  }

  /// Controller üzerinden value güncellemek için
  void setValue(double newValue) {
    _veriable = _veriable.copyWith(value: newValue) as T;
    textController.text = _formatValue(newValue);
    notifyListeners();
  }

  /// Double değerleri ".0" olmadan string yapar
  static String _formatValue(dynamic value) {
    if (value == null) return '';
    if (value is double) {
      if (value == value.toInt()) return value.toInt().toString();
      return value.toString();
    }
    return value.toString();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
