part of 'all_tools_view.dart';

mixin _AllToolsViewMixin on StatelessWidget {
  final List<ToolItemModel> _items = [
    ToolItemModel(
      title: LocaleKeys.home_deflection_calculation.lang.tr,
      description: LocaleKeys.home_used_to_calculate_deflection.lang.tr,
      iconPath: SvgEnum.map.path,
      formula: FormulaModel(
        title: LocaleKeys.home_deflection_calculation.lang.tr,
        veriables: [
          DoubleVeriable(veriableName: 'F', value: 100),
          DoubleVeriable(veriableName: 'T', value: 120),
        ],
        calculations: (List<VeriableTypes<dynamic>> veriables) {
          final f = (veriables.firstWhere((v) => v.veriableName == 'F').value
                  as DoubleVeriable)
              .value;
          final t = (veriables.firstWhere((v) => v.veriableName == 'T').value
                  as DoubleVeriable)
              .value;
          return f + t;
        },
      ),
    ),
  ];
}
