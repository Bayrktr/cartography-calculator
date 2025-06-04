// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AllToolsView]
class AllToolsRoute extends PageRouteInfo<AllToolsRouteArgs> {
  AllToolsRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AllToolsRoute.name,
          args: AllToolsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AllToolsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AllToolsRouteArgs>(
          orElse: () => const AllToolsRouteArgs());
      return AllToolsView(key: args.key);
    },
  );
}

class AllToolsRouteArgs {
  const AllToolsRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AllToolsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [CalculatePageView]
class CalculatePageRoute extends PageRouteInfo<CalculatePageRouteArgs> {
  CalculatePageRoute({
    Key? key,
    FormulaModel? formula,
    List<PageRouteInfo>? children,
  }) : super(
          CalculatePageRoute.name,
          args: CalculatePageRouteArgs(
            key: key,
            formula: formula,
          ),
          initialChildren: children,
        );

  static const String name = 'CalculatePageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CalculatePageRouteArgs>(
          orElse: () => const CalculatePageRouteArgs());
      return CalculatePageView(
        key: args.key,
        formula: args.formula,
      );
    },
  );
}

class CalculatePageRouteArgs {
  const CalculatePageRouteArgs({
    this.key,
    this.formula,
  });

  final Key? key;

  final FormulaModel? formula;

  @override
  String toString() {
    return 'CalculatePageRouteArgs{key: $key, formula: $formula}';
  }
}

/// generated route for
/// [GeneralErrorView]
class GeneralErrorRoute extends PageRouteInfo<void> {
  const GeneralErrorRoute({List<PageRouteInfo>? children})
      : super(
          GeneralErrorRoute.name,
          initialChildren: children,
        );

  static const String name = 'GeneralErrorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GeneralErrorView();
    },
  );
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return HomeView(key: args.key);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [PastCalculationsView]
class PastCalculationsRoute extends PageRouteInfo<void> {
  const PastCalculationsRoute({List<PageRouteInfo>? children})
      : super(
          PastCalculationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PastCalculationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PastCalculationsView();
    },
  );
}

/// generated route for
/// [SettingsView]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsView();
    },
  );
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashView();
    },
  );
}

/// generated route for
/// [ToolSelectionView]
class ToolSelectionRoute extends PageRouteInfo<void> {
  const ToolSelectionRoute({List<PageRouteInfo>? children})
      : super(
          ToolSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'ToolSelectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ToolSelectionView();
    },
  );
}
