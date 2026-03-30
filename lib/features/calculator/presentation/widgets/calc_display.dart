import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../calculator_controller.dart';

class CalcDisplay extends StatelessWidget {
  const CalcDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<CalculatorController>();
    final colors = Theme.of(context).colorScheme;
    final isError = ctrl.display == 'Erro';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (ctrl.pendingOp != null)
            Text(
              ctrl.pendingOp!,
              style: TextStyle(
                fontSize: 20,
                color: colors.onSurfaceVariant,
              ),
            ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (child, anim) =>
                FadeTransition(opacity: anim, child: child),
            child: FittedBox(
              key: ValueKey(ctrl.display),
              fit: BoxFit.scaleDown,
              child: Text(
                ctrl.display,
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w300,
                  color: isError ? colors.error : colors.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
