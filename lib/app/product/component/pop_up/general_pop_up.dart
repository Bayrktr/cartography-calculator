import 'package:flutter/material.dart';

enum GeneralPopUpType { success, error, warning, info }

class GeneralPopUp extends StatelessWidget {
  final String title;
  final String message;
  final GeneralPopUpType type;
  final VoidCallback? onClose;

  const GeneralPopUp({
    Key? key,
    required this.title,
    required this.message,
    this.type = GeneralPopUpType.info,
    this.onClose,
  }) : super(key: key);

  static void show({
    required BuildContext context,
    required String title,
    required String message,
    GeneralPopUpType type = GeneralPopUpType.info,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GeneralPopUp(title: title, message: message, type: type);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _config = _NotificationTypeConfig.fromType(type);

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _config.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
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
                      const SizedBox(height: 6),
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
            // Close icon
            Positioned(
              top: -6,
              right: -6,
              child: IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () {
                  Navigator.of(context).pop();
                  onClose?.call();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTypeConfig {
  final IconData iconData;
  final Color backgroundColor;

  _NotificationTypeConfig({
    required this.iconData,
    required this.backgroundColor,
  });

  factory _NotificationTypeConfig.fromType(GeneralPopUpType type) {
    switch (type) {
      case GeneralPopUpType.success:
        return _NotificationTypeConfig(
          iconData: Icons.check_circle_outline,
          backgroundColor: const Color(0xFFE6F4EA),
        );
      case GeneralPopUpType.error:
        return _NotificationTypeConfig(
          iconData: Icons.error_outline,
          backgroundColor: const Color(0xFFFFE1E1),
        );
      case GeneralPopUpType.warning:
        return _NotificationTypeConfig(
          iconData: Icons.warning_amber_outlined,
          backgroundColor: const Color(0xFFFFF3CD),
        );
      case GeneralPopUpType.info:
        return _NotificationTypeConfig(
          iconData: Icons.info_outline,
          backgroundColor: const Color(0xFFDDEEFF),
        );
    }
  }
}
