import 'package:auto_route/auto_route.dart';

enum RoutePath<T> {
  splash('/'),
  generalError('/generalError'),
  home('/home'),
  toolSelection('toolSelection'),
  allTools('allTools'),
  calculatePage('calculatePage'),
  settings('settings'),
  pastCalculations('pastCalculations'),
  ;

  const RoutePath(this.path);

  final String path;

  String get getPath => path;

  PageRouteInfo<T> get pageRouteInfo => PageRouteInfo(path);
}
