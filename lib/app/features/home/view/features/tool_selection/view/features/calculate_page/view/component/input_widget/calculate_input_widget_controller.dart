import 'package:base_cubit_widget/base_cubit_widget.dart';
import 'package:flutter/material.dart';

class CalculateInputWidgetController extends BaseCubit<Object, Object, Object> {
  CalculateInputWidgetController() : super(BaseState.initial());

  final Map<String, TextEditingController> _controllers = {};

  TextEditingController controllerFor(String key) {
    return _controllers.putIfAbsent(key, TextEditingController.new);
  }

  void updateController(String key, String? value) {
    if (value == null) return;
    final controller = controllerFor(key);
    if (controller.text != value) {
      controller.text = value;
    }
  }

  @override
  Future<void> onInit() async {}
}
