import 'package:calculator/app/product/state/base/cubit/base_cubit.dart';
import 'package:calculator/app/product/state/base/cubit/base_state.dart';
import 'package:flutter/cupertino.dart';

class CalculateInputWidgetController extends BaseCubit<Object, Object, Object,
    BaseState<Object, Object, Object>> {
  CalculateInputWidgetController()
      : super(
          BaseState.loading(),
        );

  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  @override
  Future<void> onInit() async {}

  void updateController(String? value) {
    if (value == null) return;
    _controller.text = value;
  }
}
