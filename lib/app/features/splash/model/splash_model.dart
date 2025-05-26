import 'package:calculator/app/features/splash/model/splash_navigate_model.dart';
import 'package:equatable/equatable.dart';

class SplashModel with EquatableMixin {
  SplashModel({
    this.navigate = const SplashNoneNavigateModel(),
  });

  final SplashNavigateModel navigate;

  @override
  List<Object?> get props => [navigate];

  SplashModel copyWith({SplashNavigateModel? navigate}) => SplashModel(
        navigate: navigate ?? this.navigate,
      );
}
