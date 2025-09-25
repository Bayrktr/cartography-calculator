import 'package:auto_route/auto_route.dart';
import 'package:base_cubit_widget/base_cubit_widget.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/features/splash/controller/splash_controller.dart';
import 'package:calculator/app/features/splash/model/splash_navigate_model.dart';
import 'package:calculator/app/product/component/image/custom_image.dart';
import 'package:calculator/app/product/enum/svg_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SplashController();
    return BlocProvider(
      create: (_) => controller,
      child: BaseCubitWidget(
        blocType: BlocType.both,
        bloc: controller,
        initialBuilder: (state) {
          final splashData = state.model;

          return Container();
        },
        loadingBuilder: (state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImage(
                    imageFrom: ImageFrom.ASSET,
                    imageType: ImageType.SVG,
                    assetPath: SvgEnum.earth.path,
                    radius: context.radius.high,
                  ),
                ],
              ),
            ),
          );
        },
        initialListener: (context, state) {
          final data = state.model;
          final navigateModel = data?.navigate;
          switch (navigateModel) {
            case null:
            case SplashNoneNavigateModel():
            case SplashHomeNavigateModel():
              context.router.replace(
                navigateModel!.route,
              );
          }
        },
      ),
    );
  }
}
