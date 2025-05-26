import 'package:calculator/app/features/splash/model/splash_model.dart';
import 'package:calculator/app/features/splash/model/splash_navigate_model.dart';
import 'package:calculator/app/product/state/base/cubit/base_cubit.dart';
import 'package:calculator/app/product/state/base/cubit/base_state.dart';
import 'package:calculator/app/product/state/base/cubit/model/initial/base_initial_data_model.dart';

class SplashController extends BaseCubit<SplashModel, Object, Object,
    BaseState<SplashModel, Object, Object>> {
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
