import 'package:calculator/app/product/component/loading/general_circular_progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralScaffold extends StatelessWidget {
  const GeneralScaffold({
    super.key,
    this.isLoading = false,
    this.scaffold,
    this.appBar,
    this.body,
    this.drawer,
    this.floatingActionButton,
    this.isBodySafe = true,
    this.scaffoldKey,
  });

  final bool isLoading;
  final Widget? scaffold;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final bool isBodySafe;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        scaffold ??
            Scaffold(
              key: scaffoldKey,
              floatingActionButton: floatingActionButton,
              appBar: appBar,
              drawer: drawer,
              body: (isBodySafe)
                  ? SafeArea(child: body ?? const SizedBox.shrink())
                  : body,
            ),
        if (isLoading)
          const GeneralCircularProgress()
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
