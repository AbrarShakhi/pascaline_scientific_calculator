import 'operand.dart';
import 'expression.dart';
import 'operator.dart';

class ExpressionManager {
  InfixExpression _infixExpression;
  List<int> _numberBuffer;

  ExpressionManager._(this._infixExpression, this._numberBuffer);

  factory ExpressionManager() {
    return ExpressionManager._(InfixExpression(), []);
  }

  void _registerNumbers() {
    if (_numberBuffer.isEmpty) {
      return;
    }

    final stringBuffer = StringBuffer();
    for (var charCode in _numberBuffer) {
      stringBuffer.writeCharCode(charCode);
    }

    _infixExpression.pushToken(Operand(stringBuffer.toString()));
    _numberBuffer.clear();
  }

  void allClear() {
    _infixExpression.clear();
    _numberBuffer.clear();
  }

  void pushOperator(IOperator op) {
    _registerNumbers();
    _infixExpression.pushToken(op);
  }

  void pushSingleOperand(int char) {
    _numberBuffer.add(char);
  }

  void popAny() {
    if (_numberBuffer.isNotEmpty) {
      _numberBuffer.removeLast();
    }
    // TODO:
    // if _numberBuffer is emppty.
    //      then its hight likely previous token in _infixExpression will be operator.
    //      just need to pop that from _infixExpression. (make sure _infixExpression is not empty)
    //
    // if previous token from _infixExpression is not operator means operand (possibly invalid expression).
    //      but need to test it.
    //      if that happens then pop the operand from _infixExpression convert from string to int array.
    //      remove the last value.
    //      insert back as operator.
    //      need a faster method
  }

  // TODO:
  // cusror managemnet
  // infix and postfix has to be modified for cursor management.

  num calculate() {
    _registerNumbers();
    return PostfixExpression(_infixExpression).evaluate();
  }
}
