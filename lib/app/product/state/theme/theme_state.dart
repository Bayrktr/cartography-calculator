import 'package:calculator/app/product/model/theme/all_themes.dart';
import 'package:equatable/equatable.dart';



class ThemeState with EquatableMixin {
  ThemeState({this.selectedTheme}) {
    selectedTheme = CustomLightTheme();
  }

  AllThemes? selectedTheme;

  @override
  List<Object?> get props => [
        selectedTheme,
      ];

  ThemeState copyWith({AllThemes? selectedTheme}) => ThemeState(
        selectedTheme: selectedTheme ?? this.selectedTheme,
      );
}
