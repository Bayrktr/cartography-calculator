import 'package:flutter/material.dart';
import 'package:calculator/app/product/state/base/cubit/base_cubit.dart';
import 'package:calculator/app/product/state/base/cubit/base_state.dart';

class CalculateInputWidgetController extends BaseCubit<Object, Object, Object, BaseState<Object, Object, Object>> {
  CalculateInputWidgetController() : super(BaseState.initial());

  final Map<String, TextEditingController> _controllers = {};

  TextEditingController controllerFor(String key) {
    return _controllers.putIfAbsent(key, () => TextEditingController());
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
