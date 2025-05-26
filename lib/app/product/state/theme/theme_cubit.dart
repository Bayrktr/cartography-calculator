import 'package:bloc/bloc.dart';
import 'package:calculator/app/product/cache/hive/operation/theme_operation.dart';
import 'package:calculator/app/product/manager/getIt/getIt_manager.dart';
import 'package:calculator/app/product/model/theme/all_themes.dart';
import 'package:calculator/app/product/state/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState()) {
    onInit();
  }

  final ThemeOperation _themeOperation = GetItManager.getIt<ThemeOperation>();

  Future<void> onInit() async {
    final theme = _themeOperation.getItem(AllThemes.value);
    emit(
      state.copyWith(
        selectedTheme: theme ?? CustomLightTheme(),
      ),
    );
  }
}
