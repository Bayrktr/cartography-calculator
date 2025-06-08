import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/features/base/base_view.dart';
import 'package:calculator/app/features/home/model/home_view_bottom_bar_item_model.dart';
import 'package:calculator/app/product/component/image/custom_image.dart';
import 'package:calculator/app/product/enum/custom_icons_enum.dart';
import 'package:calculator/app/product/enum/svg_enum.dart';
import 'package:calculator/app/product/navigation/app_router.dart';
import 'package:flutter/material.dart';

part 'home_view_mixin.dart';

@RoutePage()
class HomeView extends BaseView with HomeViewMixin {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      builder: (context, child, tabController) {
        final currentRouteName = context.topRoute.name;
        final showBottomBar = currentRouteName != CalculatePageRoute.name;

        return Scaffold(
          body: child,
          bottomNavigationBar: showBottomBar
              ? BottomNavigationBar(
            currentIndex: context.tabsRouter.activeIndex,
            onTap: (index) {
              context.tabsRouter.setActiveIndex(index);
            },
            items: List.generate(
              items.length,
                  (index) {
                final item = items[index];
                final activeIndex = context.tabsRouter.activeIndex;
                final isActive = activeIndex == index;
                return BottomNavigationBarItem(
                  label: '',
                  icon: CustomImage(
                    imageFrom: ImageFrom.ASSET,
                    imageType: ImageType.SVG,
                    assetPath: item.iconPath,
                    radius: context.radius.low,
                    color: isActive
                        ? context.theme.bottomNavigationBarTheme.selectedItemColor
                        : context.theme.bottomNavigationBarTheme.unselectedItemColor,
                  ),
                );
              },
            ),
          )
              : null,
        );
      },
      routes: routes,
    );
  }

}
