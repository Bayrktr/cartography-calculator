part of 'input_widget/calculate_input_widget.dart';
class _DistanceTextField extends StatelessWidget {
  const _DistanceTextField({
    required this.veriable,
    required this.controller,
  });

  final VeriableTypes<dynamic> veriable;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sized.heightNormalValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(veriable.title, style: context.theme.textTheme.titleLarge),
          Padding(
            padding: EdgeInsets.only(bottom: context.sized.heightNormalValue),
            child: const Divider(),
          ),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            cursorColor: context.theme.primaryColor,
            style: context.theme.textTheme.titleSmall,
            decoration: InputDecoration(
              hintText: LocaleKeys.general_inputValue.lang.tr,
              suffixText: veriable.unit,
              icon: Icon(Icons.straighten, color: context.theme.primaryColor),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.theme.inputDecorationTheme.border!.borderSide.color,
                ),
                borderRadius: context.borderRadius.dynamicRadius(0.03),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context.theme.inputDecorationTheme.border!.borderSide.color,
                ),
                borderRadius: context.borderRadius.dynamicRadius(0.03),
              ),
            ),
            onChanged: (value) {
              final parsed = double.tryParse(value);
              if (parsed != null) {
                context.read<CalculatePageController>().updateVeriable(
                  veriable.copyWith(value: parsed),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
