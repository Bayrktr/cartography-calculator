part of 'home_view.dart';

mixin HomeViewMixin on StatelessWidget {
  final List<HomeViewBottomBarItemModel<dynamic>> items = [
    HomeViewBottomBarItemModel<dynamic>(
      route: const ToolSelectionRoute(),
      name: 'Tool Selection',
      iconPath: SvgEnum.ruler.path,
    ),
    HomeViewBottomBarItemModel<dynamic>(
      route: const PastCalculationsRoute(),
      name: 'Past Calculations',
      iconPath: SvgEnum.save.path,
    ),
    HomeViewBottomBarItemModel<dynamic>(
      route: const SettingsRoute(),
      name: 'Settings',
      iconPath: SvgEnum.person.path,
    ),
  ];

  late final routes = items.map((e) => e.route).toList();

}
