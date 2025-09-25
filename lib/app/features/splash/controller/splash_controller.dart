import 'package:base_cubit_widget/base_cubit_widget.dart';
import 'package:calculator/app/features/splash/model/splash_model.dart';
import 'package:calculator/app/features/splash/model/splash_navigate_model.dart';

class SplashController extends BaseCubit<SplashModel, Object, Object> {
  SplashController()
      : super(
          BaseState.loading(),
        );

  @override
  Future<void> onInit() async {
    await initApp();
  }

  Future<void> initApp() async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    emit(
      BaseState.initial(
        data: BaseInitialDataModel<SplashModel>(
          data: SplashModel(
            navigate: const SplashHomeNavigateModel(),
          ),
        ),
      ),
    );
  }
}
