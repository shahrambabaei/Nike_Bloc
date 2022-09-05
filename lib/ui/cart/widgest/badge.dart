import 'package:flutter/material.dart';
import 'package:nike/configs/theme.dart';

class Badge extends StatelessWidget {
  const Badge({super.key, required this.value});
  final int value;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value > 0,
      child: Container(
        width: 18,
        height: 18,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: LightThemeColors.primaryColor, shape: BoxShape.circle),
        child: Text(
          value.toString(),
          style: const TextStyle(
              color: LightThemeColors.onPrimaryColor, fontSize: 12),
        ),
      ),
    );
  }
}
