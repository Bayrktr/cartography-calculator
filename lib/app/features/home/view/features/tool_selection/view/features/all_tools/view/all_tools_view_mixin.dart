part of 'all_tools_view.dart';

mixin _AllToolsViewMixin on StatelessWidget {
  final List<ToolItemModel> _items = [
    ToolItemModel(
      title: LocaleKeys.home_deflection_calculation.lang.tr,
      description: LocaleKeys.home_used_to_calculate_deflection.lang.tr,
      iconPath: SvgEnum.map.path,
      formula: FormulaModel(
        title: LocaleKeys.home_deflection_calculation.lang.tr,
        formulaType: DeflectionFormula(
          veriables: DeflectionVeriablesModel(
            F: DistanceVeriable(
              veriableName: 'F',
              title: LocaleKeys.deflection_fTitle.lang.tr,
            ),
            T: DistanceVeriable(
              veriableName: 'T',
              title: LocaleKeys.deflection_tTitle.lang.tr,
            ),
            A: DistanceVeriable(
              veriableName: 'A',
              title: LocaleKeys.deflection_aTitle.lang.tr,
            ),
            b: DegreeVeriable(
              veriableName: 'b',
              title: LocaleKeys.deflection_bTitle.lang.tr,
            ),
          ),
        ),
      ),
    ),
  ];
}
