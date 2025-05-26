import 'package:auto_route/auto_route.dart';
import 'package:calculator/app/product/navigation/app_router.dart';

sealed class SplashNavigateModel {
  const SplashNavigateModel();

  PageRouteInfo<dynamic>? get _internalRoute;

  PageRouteInfo<dynamic> get route =>
      _internalRoute ?? const GeneralErrorRoute();
}

class SplashNoneNavigateModel extends SplashNavigateModel {
  const SplashNoneNavigateModel();

  @override
  PageRouteInfo? get _internalRoute => const GeneralErrorRoute();
}

class SplashHomeNavigateModel extends SplashNavigateModel {
  const SplashHomeNavigateModel();

  @override
  PageRouteInfo? get _internalRoute => HomeRoute();
}
