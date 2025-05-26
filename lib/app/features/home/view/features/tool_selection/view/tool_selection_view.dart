

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calculator/app/features/base/base_view.dart';
import 'package:flutter/material.dart';


@RoutePage()
class ToolSelectionView extends BaseView {
  const ToolSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
