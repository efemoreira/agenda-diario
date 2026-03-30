/// Lógica pura da calculadora — sem dependências de UI ou Flutter
class CalculatorLogic {
  /// Processa a entrada de um dígito ou ponto decimal
  String processDigit({
    required String display,
    required bool justCalculated,
    required String digit,
  }) {
    if (justCalculated) {
      return digit == '.' ? '0.' : digit;
    }
    if (digit == '.') {
      if (display.contains('.')) return display;
      return '$display.';
    }
    if (display == '0' || display == 'Erro') return digit;
    if (display.length >= 12) return display;
    return '$display$digit';
  }

  /// Aplica o operador pendente — retorna null se divisão por zero
  double? applyOperator({
    required double stored,
    required double current,
    required String op,
  }) {
    switch (op) {
      case '+':
        return stored + current;
      case '−':
        return stored - current;
      case '×':
        return stored * current;
      case '÷':
        if (current == 0) return null;
        return stored / current;
      default:
        return current;
    }
  }

  /// Formata um resultado double para exibição no display
  String formatResult(double value) {
    if (value.isInfinite || value.isNaN) return 'Erro';
    if (value == value.truncateToDouble()) {
      final str = value.toStringAsFixed(0);
      return str.length > 12 ? 'Erro' : str;
    }
    final trimmed = value
        .toStringAsFixed(9)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
    return trimmed.length > 12 ? value.toStringAsExponential(4) : trimmed;
  }
}
