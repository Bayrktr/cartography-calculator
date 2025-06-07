part of 'input_widget/calculate_input_widget.dart';

class _DistanceTextField extends StatelessWidget {
  _DistanceTextField({
    super.key,
    required this.veriable,
    required this.controller,
  });

  final TextEditingController controller;

  final VeriableTypes<dynamic> veriable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            veriable.title,
            style: context.theme.textTheme.titleLarge,
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: context.sized.heightNormalValue,
            ),
            child: Divider(),
          ),
          TextField(
            keyboardType: TextInputType.number,
            cursorColor: context.theme.primaryColor,
            controller: controller,
            inputFormatters: [
              //FilteringTextInputFormatter.allow(RegExpConstant.numberFormatter),
            ],
            decoration: InputDecoration(
              hintText: LocaleKeys.general_inputValue.lang.tr,
              suffixText: veriable.unit,
              icon: Icon(
                Icons.straighten,
                color: context.theme.primaryColor,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context
                      .theme.inputDecorationTheme.border!.borderSide.color,
                ),
                borderRadius: context.borderRadius.dynamicRadius(
                  0.03,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: context
                      .theme.inputDecorationTheme.border!.borderSide.color,
                ),
                borderRadius: context.borderRadius.dynamicRadius(
                  0.03,
                ),
              ),
            ),
            onChanged: (String? value) {
              value = value ?? '0';
              if (!RegExpConstant.numberFormatter.hasMatch(value)) {
                // fixme
              }
              try {
                final parsedValue = double.parse(value);
                print('value: $parsedValue');
                context.read<CalculatePageController>().updateVeriable(
                      veriable.copyWith(
                        value: parsedValue,
                      ),
                    );
              } catch (e) {}
            },
          ),
        ],
      ),
    );
  }
}
