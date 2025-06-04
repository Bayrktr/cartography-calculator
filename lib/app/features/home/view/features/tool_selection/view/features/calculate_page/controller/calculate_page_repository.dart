import 'package:calculator/app/product/enum/endpoints_enum.dart';
import 'package:calculator/app/product/manager/getIt/getIt_manager.dart';
import 'package:calculator/app/product/model/calculations/base_formula_model.dart';
import 'package:calculator/app/product/model/calculations/formula_response_model.dart';
import 'package:calculator/app/product/service/dio_service/dio_service.dart';
import 'package:calculator/app/product/service/model/response_model.dart';

class CalculatePageRepository {
  final _dioService = GetItManager.getIt<DioService>();

  Future<ResponseModel<FormulaResponseModel>> getGptResult(
    BaseFormulaModel formulaType,
    Map<String, dynamic> data,
  ) async {
    final endpoint = formulaEndpoint(formulaType);

    return _dioService.post<FormulaResponseModel>(
      endpoint,
      model: FormulaResponseModel(),
      data: data,
    );
  }

  String formulaEndpoint(BaseFormulaModel formulaType) {
    switch (formulaType) {
      case DeflectionFormula():
        return EndpointsEnum.deflectionGpt.testLocalhost;
    }
  }
}
