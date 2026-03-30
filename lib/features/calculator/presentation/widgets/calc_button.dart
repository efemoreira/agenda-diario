import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String label;
  final bool isOperator;
  final bool isEquals;
  final bool isClear;
  final bool isActive;
  final VoidCallback onTap;

  const CalcButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isOperator = false,
    this.isEquals = false,
    this.isClear = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Color bgColor;
    Color fgColor;

    if (isEquals) {
      bgColor = colors.primary;
      fgColor = colors.onPrimary;
    } else if (isActive) {
      bgColor = colors.primaryContainer;
      fgColor = colors.onPrimaryContainer;
    } else if (isOperator) {
      bgColor = colors.secondaryContainer;
      fgColor = colors.onSecondaryContainer;
    } else if (isClear) {
      bgColor = colors.errorContainer;
      fgColor = colors.onErrorContainer;
    } else {
      bgColor = colors.surfaceContainerHighest;
      fgColor = colors.onSurface;
    }

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: fgColor,
            ),
          ),
        ),
      ),
    );
  }
}
