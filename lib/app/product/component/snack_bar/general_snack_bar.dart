import 'package:calculator/app/core/extention/build_context/build_context_extension.dart';
import 'package:flutter/material.dart';

enum GeneralSnackBarType { success, error, warning, info }

class GeneralSnackBar {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    GeneralSnackBarType type = GeneralSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final _config = _SnackBarTypeConfig.fromType(type);

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      elevation: 4,
      duration: duration,
      content: Row(
        children: [
          // Icon container
          Container(
            padding: context.padding.low,
            decoration: BoxDecoration(
              color: _config.backgroundColor,
              borderRadius: context.borderRadius.low,
            ),
            child: Icon(
              _config.iconData,
              color: Colors.black87,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          // Title + Message
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class _SnackBarTypeConfig {
  final IconData iconData;
  final Color backgroundColor;

  _SnackBarTypeConfig({
    required this.iconData,
    required this.backgroundColor,
  });

  factory _SnackBarTypeConfig.fromType(GeneralSnackBarType type) {
    switch (type) {
      case GeneralSnackBarType.success:
        return _SnackBarTypeConfig(
          iconData: Icons.check_circle_outline,
          backgroundColor: const Color(0xFFE6F4EA),
        );
      case GeneralSnackBarType.error:
        return _SnackBarTypeConfig(
          iconData: Icons.error_outline,
          backgroundColor: const Color(0xFFFFE1E1),
        );
      case GeneralSnackBarType.warning:
        return _SnackBarTypeConfig(
          iconData: Icons.warning_amber_outlined,
          backgroundColor: const Color(0xFFFFF3CD),
        );
      case GeneralSnackBarType.info:
        return _SnackBarTypeConfig(
          iconData: Icons.info_outline,
          backgroundColor: const Color(0xFFDDEEFF),
        );
    }
  }
}
