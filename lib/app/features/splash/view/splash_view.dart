import 'package:auto_route/auto_route.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/features/splash/controller/splash_controller.dart';
import 'package:calculator/app/features/splash/model/splash_model.dart';
import 'package:calculator/app/features/splash/model/splash_navigate_model.dart';
import 'package:calculator/app/product/component/image/custom_image.dart';
import 'package:calculator/app/product/enum/svg_enum.dart';
import 'package:calculator/app/product/state/base/cubit/base_state.dart';
import 'package:calculator/app/product/state/base/cubit/widget/base_cubit_widget.dart';
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
        initial: (state) {
          final splashData = state.model;

          return Container();
        },
        loading: (state) {
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
        listener: (context, state) {
          switch (state) {
            case BaseInitialModel<SplashModel, Object, Object>():
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

            case BaseLoadingModel<SplashModel, Object, Object>():
            case BaseErrorModel<SplashModel, Object, Object>():
          }
        },
      ),
    );
  }
}
