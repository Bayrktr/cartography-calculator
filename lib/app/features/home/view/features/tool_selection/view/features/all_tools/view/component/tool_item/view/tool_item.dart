part of '../../../all_tools_view.dart';

class _ToolItem extends StatelessWidget {
  const _ToolItem({required this.item, super.key});

  final ToolItemModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){},
      leading: Container(
        decoration: BoxDecoration(
          color: context.theme.bottomNavigationBarTheme.backgroundColor,
          borderRadius: context.borderRadius.low,
        ),
        padding: context.padding.low,
        child: CustomImage(
          imageFrom: ImageFrom.ASSET,
          imageType: ImageType.SVG,
          assetPath: SvgEnum.ruler.path,
          color: context.theme.iconTheme.color,
        ),
      ),
      title: Text(
        item.title,
        style: context.theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        item.description,
        style: context.theme.textTheme.bodyMedium,
      ),
    );
  }
}
