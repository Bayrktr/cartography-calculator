part of '../calculate_page_view.dart';

class _CalculateButton extends StatelessWidget {
  const _CalculateButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: context.padding.normal,
        ),
        onPressed: onPressed,
        child: LocaleText(
          text: LocaleKeys.general_calculate,
          textStyle: context.theme.textTheme.titleMedium,
          color: context.theme.textTheme.bodyLarge!.color,
        ),
      ),
    );
  }
}
