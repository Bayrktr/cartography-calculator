import 'package:auto_route/annotations.dart';
import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:calculator/app/core/extention/string/string_extention.dart';
import 'package:calculator/app/features/home/view/features/tool_selection/view/features/all_tools/view/component/tool_item/model/tool_item_model.dart';
import 'package:calculator/app/product/component/image/custom_image.dart';
import 'package:calculator/app/product/component/text/locale_text.dart';
import 'package:calculator/app/product/enum/svg_enum.dart';
import 'package:calculator/app/product/model/calculations/formula_model.dart';
import 'package:calculator/app/product/model/calculations/veriable_types.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

part 'all_tools_view_mixin.dart';

part 'component/tool_item/view/tool_item.dart';

@RoutePage()
class AllToolsView extends StatelessWidget with _AllToolsViewMixin {
  AllToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.padding.normal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: LocaleText(
                text: LocaleKeys.home_calculations,
                textStyle: context.theme.textTheme.titleMedium,
              ),
            ),
            Expanded(
              flex: 30,
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _items[index];
                  return _ToolItem(item: item);
                },
              ),
            )
          ],
        ),
      ),
      appBar: _appBar(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: LocaleText(
        text: LocaleKeys.home_cartography_tools,
        textStyle: context.theme.textTheme.titleLarge,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: CustomImage(
            imageFrom: ImageFrom.ASSET,
            imageType: ImageType.SVG,
            assetPath: SvgEnum.settings.path,
            color: context.theme.iconTheme.color,
          ),
        ),
      ],
    );
  }
}
