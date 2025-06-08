import 'package:auto_route/auto_route.dart';
import 'package:calculator/app/features/error/general/view/general_error_view.dart';
import 'package:calculator/app/features/home/view/features/past_calculations/view/past_calculations_view.dart';
import 'package:calculator/app/features/home/view/features/settings/view/settings_view.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/all_tools/view/all_tools_view.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/calculate_page/view/calculate_page_view.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/tool_selection_view.dart';
import 'package:calculator/app/features/home/view/home_view.dart';
import 'package:calculator/app/features/splash/view/splash_view.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/navigation/route_path.dart';
import 'package:flutter/material.dart';


part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AdaptiveRoute<SplashRoute>(
          page: SplashRoute.page,
          path: RoutePath.splash.getPath,
          initial: true,
        ),
        AdaptiveRoute<GeneralErrorRoute>(
          page: GeneralErrorRoute.page,
          path: RoutePath.generalError.getPath,
        ),
        AdaptiveRoute<HomeRoute>(
          page: HomeRoute.page,
          path: RoutePath.home.getPath,
          children: [
            AdaptiveRoute<ToolSelectionRoute>(
              page: ToolSelectionRoute.page,
              path: RoutePath.toolSelection.getPath,
              children: [
                AdaptiveRoute<AllToolsRoute>(
                  page: AllToolsRoute.page,
                  path: RoutePath.allTools.getPath,
                  initial: true,
                ),
                AdaptiveRoute<AllToolsRoute>(
                  page: CalculatePageRoute.page,
                  path: RoutePath.calculatePage.getPath,
                ),
              ],
            ),
            AdaptiveRoute<SettingsRoute>(
              page: SettingsRoute.page,
              path: RoutePath.settings.getPath,
            ),
            AdaptiveRoute<PastCalculationsRoute>(
              page: PastCalculationsRoute.page,
              path: RoutePath.pastCalculations.getPath,
            ),
          ],
        ),
      ];
}
