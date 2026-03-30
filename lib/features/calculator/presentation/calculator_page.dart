import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'calculator_controller.dart';
import 'widgets/calc_button.dart';
import 'widgets/calc_display.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  static const _buttons = [
    ['C', '⌫', '%', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '−'],
    ['1', '2', '3', '+'],
    ['±', '0', '.', '='],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(flex: 2, child: CalcDisplay()),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Consumer<CalculatorController>(
                  builder: (_, ctrl, __) => Column(
                    children: _buttons.map((row) {
                      return Expanded(
                        child: Row(
                          children: row.map((label) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: CalcButton(
                                  label: label,
                                  isOperator: _isOperator(label),
                                  isEquals: label == '=',
                                  isClear: label == 'C',
                                  isActive:
                                      ctrl.pendingOp == label && label != '=',
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    _onTap(ctrl, label);
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isOperator(String label) =>
      label == '÷' ||
      label == '×' ||
      label == '−' ||
      label == '+' ||
      label == '%' ||
      label == '±';

  void _onTap(CalculatorController ctrl, String label) {
    switch (label) {
      case 'C':
        ctrl.clear();
      case '⌫':
        ctrl.backspace();
      case '=':
        ctrl.calculate();
      case '%':
        // percentual: divide display por 100
        final v = double.tryParse(ctrl.display) ?? 0;
        final pct = v / 100;
        ctrl.clear();
        for (final ch in pct.toString().split('')) {
          ctrl.inputDigit(ch);
        }
      case '±':
        final v = double.tryParse(ctrl.display) ?? 0;
        final toggled = (v * -1).toString();
        ctrl.clear();
        for (final ch in toggled.split('')) {
          ctrl.inputDigit(ch);
        }
      case '+':
      case '−':
      case '×':
      case '÷':
        ctrl.inputOperator(label);
      default:
        ctrl.inputDigit(label);
    }
  }
}
