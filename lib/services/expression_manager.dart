import 'operator.dart';
import 'expression.dart';
import 'operand.dart';

class ExpressionManager {
  final InfixExpression _expression;
  final List<int> _operandBuffer = [];

  ExpressionManager._(this._expression);

  factory ExpressionManager() {
    return ExpressionManager._(InfixExpression());
  }

  void clear() {
    _expression.clear();
    _operandBuffer.clear();
  }

  List<IToken> get expression => _expression.items;

  bool get isParsed => _expression.isNotEmpty;

  static Operand _makeOperand(List<int> operandBuffer) {
    final operand = Operand.fromList(operandBuffer);
    operandBuffer.clear();
    return operand;
  }

  void parseInfix(String inputString) {
    if (_expression.isNotEmpty) {
      throw Exception("Expression is already parsed. clear it to parse a new.");
    }
    if (inputString.isEmpty) {
      _expression.pushToken(Operand.fromString('0'));
    }

    _operandBuffer.clear();
    for (final roune in inputString.runes) {
      IOperator? operator_;

      if (String.fromCharCode(roune) == ' ') {
        continue;
      }

      try {
        operator_ = IOperator.findChild(roune);
      } catch (e) {
        _operandBuffer.add(roune);
      }

      if (operator_ != null) {
        if (_operandBuffer.isNotEmpty) {
          _expression.pushToken(_makeOperand(_operandBuffer));
        }
        _expression.pushToken(operator_);
      }
      operator_ = null;
    }
    if (_operandBuffer.isNotEmpty) {
      _expression.pushToken(_makeOperand(_operandBuffer));
    }
  }

  num calculate() {
    return PostfixExpression(_expression).evaluate();
  }
}
