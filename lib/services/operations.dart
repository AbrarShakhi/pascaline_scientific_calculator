import 'dart:math';
import 'operator.dart';

class Addition implements IOperator {
  @override
  num evaluteAction(num left, num right) => left + right;

  @override
  String toString() => "+";

  @override
  int get precendece => 1;

  @override
  void mutateToPostfix(
    IToken token,
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.last.precendece >= precendece) {
      postfix.add(operatorStack.removeLast());
    }
    operatorStack.add(token as IOperator);
  }
}

class Substraction implements IOperator {
  @override
  num evaluteAction(num left, num right) => left - right;

  @override
  String toString() => "-";

  @override
  int get precendece => 1;

  @override
  void mutateToPostfix(
    IToken token,
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.last.precendece >= precendece) {
      postfix.add(operatorStack.removeLast());
    }
    operatorStack.add(token as IOperator);
  }
}

class Multiplication implements IOperator {
  @override
  num evaluteAction(num left, num right) => left * right;

  @override
  String toString() => "*";

  @override
  int get precendece => 2;

  @override
  void mutateToPostfix(
    IToken token,
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.last.precendece >= precendece) {
      postfix.add(operatorStack.removeLast());
    }
    operatorStack.add(token as IOperator);
  }
}

class Division implements IOperator {
  @override
  num evaluteAction(num left, num right) => left / right;

  @override
  String toString() => "/";

  @override
  int get precendece => 2;

  @override
  void mutateToPostfix(
    IToken token,
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.last.precendece >= precendece) {
      postfix.add(operatorStack.removeLast());
    }
    operatorStack.add(token as IOperator);
  }
}

class Exponentiation implements IOperator {
  @override
  num evaluteAction(num left, num right) => pow(left, right);

  @override
  String toString() => "^";

  @override
  int get precendece => 3;

  @override
  void mutateToPostfix(
    IToken token,
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.last.precendece >= precendece) {
      postfix.add(operatorStack.removeLast());
    }
    operatorStack.add(token as IOperator);
  }
}

class OpenParentheses implements IOperator, Parentheses {
  @override
  num evaluteAction(num left, num right) =>
      throw Exception("Can not evalute 'Parentheses'");

  @override
  String toString() => "(";

  @override
  int get precendece => 0;

  @override
  ParenthesesKind get kind => ParenthesesKind.open;

  @override
  void mutateToPostfix(
    IToken token,
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    operatorStack.add(token as OpenParentheses);
  }
}

class CloseParentheses implements IOperator, Parentheses {
  @override
  num evaluteAction(num left, num right) =>
      throw Exception("Can not evalute 'Parentheses'");

  @override
  String toString() => ")";

  @override
  int get precendece => 5;

  @override
  ParenthesesKind get kind => ParenthesesKind.close;

  @override
  void mutateToPostfix(
    IToken token,
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty && operatorStack.last is! OpenParentheses) {
      postfix.add(operatorStack.removeLast());
    }

    if (operatorStack.isNotEmpty && operatorStack.last is OpenParentheses) {
      operatorStack.removeLast();
    }
  }
}
