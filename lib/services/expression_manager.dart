import 'operand.dart';
import 'expression.dart';
import 'operator.dart';

class ExpressionManager {
  InfixExpression _infixExpression;
  StringBuffer _numberBuffer;

  ExpressionManager._(this._infixExpression, this._numberBuffer);

  factory ExpressionManager() {
    return ExpressionManager._(InfixExpression(), StringBuffer());
  }

  bool _registerNumbers() {
    if (_numberBuffer.isEmpty) {
      return false;
    }
    _infixExpression.addToken(Operand(_numberBuffer.toString()));
    _numberBuffer.clear();
    return true;
  }

  void allClear() {
    _infixExpression.clear();
    _numberBuffer.clear();
  }

  void addOperator(IOperator op) {
    _infixExpression.addToken(op);
    _registerNumbers();
  }

  num calculate() => PostfixExpression(_infixExpression).evaluate();
}
