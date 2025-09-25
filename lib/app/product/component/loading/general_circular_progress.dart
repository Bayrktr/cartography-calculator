import 'package:flutter/material.dart';

class GeneralCircularProgress extends StatelessWidget {
  const GeneralCircularProgress();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black.withOpacity(0.4),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}