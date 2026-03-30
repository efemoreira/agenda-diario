import 'package:flutter/material.dart';

import '../data/calculator_logic.dart';

class CalculatorController extends ChangeNotifier {
  final _logic = CalculatorLogic();

  String _display = '0';
  double? _stored;
  String? _pendingOp;
  bool _justCalculated = false;

  String get display => _display;
  String? get pendingOp => _pendingOp;

  void inputDigit(String digit) {
    _display = _logic.processDigit(
      display: _display,
      justCalculated: _justCalculated,
      digit: digit,
    );
    _justCalculated = false;
    notifyListeners();
  }

  void inputOperator(String op) {
    if (_display == 'Erro') return;
    final current = _parseDisplay();
    if (_stored != null && _pendingOp != null && !_justCalculated) {
      final result = _logic.applyOperator(
        stored: _stored!,
        current: current,
        op: _pendingOp!,
      );
      if (result == null) {
        _setError();
        return;
      }
      _stored = result;
      _display = _logic.formatResult(result);
    } else {
      _stored = current;
    }
    _pendingOp = op;
    _justCalculated = true;
    notifyListeners();
  }

  void calculate() {
    if (_stored == null || _pendingOp == null) return;
    if (_display == 'Erro') return;
    final current = _parseDisplay();
    final result = _logic.applyOperator(
      stored: _stored!,
      current: current,
      op: _pendingOp!,
    );
    if (result == null) {
      _setError();
    } else {
      _display = _logic.formatResult(result);
    }
    _stored = null;
    _pendingOp = null;
    _justCalculated = true;
    notifyListeners();
  }

  void clear() {
    _display = '0';
    _stored = null;
    _pendingOp = null;
    _justCalculated = false;
    notifyListeners();
  }

  void backspace() {
    if (_justCalculated || _display == 'Erro') {
      _display = '0';
      _justCalculated = false;
    } else if (_display.length <= 1) {
      _display = '0';
    } else {
      _display = _display.substring(0, _display.length - 1);
      if (_display == '-') _display = '0';
    }
    notifyListeners();
  }

  double _parseDisplay() => double.tryParse(_display) ?? 0;

  void _setError() {
    _display = 'Erro';
    _stored = null;
    _pendingOp = null;
    _justCalculated = true;
    notifyListeners();
  }
}
