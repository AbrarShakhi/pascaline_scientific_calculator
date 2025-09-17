import 'dart:math';
import 'stack_list.dart';
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
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.top.precendece >= precendece) {
      postfix.push(operatorStack.pop());
    }
    operatorStack.push(token as IOperator);
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
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.top.precendece >= precendece) {
      postfix.push(operatorStack.pop());
    }
    operatorStack.push(token as IOperator);
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
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.top.precendece >= precendece) {
      postfix.push(operatorStack.pop());
    }
    operatorStack.push(token as IOperator);
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
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.top.precendece >= precendece) {
      postfix.push(operatorStack.pop());
    }
    operatorStack.push(token as IOperator);
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
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty &&
        operatorStack.top.precendece >= precendece) {
      postfix.push(operatorStack.pop());
    }
    operatorStack.push(token as IOperator);
  }
}

class OpenParentheses implements IOperator, Parentheses {
  @override
  num evaluteAction(num left, num right) => 0;

  @override
  String toString() => "(";

  @override
  int get precendece => 0;

  @override
  ParenthesesKind get kind => ParenthesesKind.open;

  @override
  void mutateToPostfix(
    IToken token,
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    operatorStack.push(token as OpenParentheses);
  }
}

class CloseParentheses implements IOperator, Parentheses {
  @override
  num evaluteAction(num left, num right) => 0;

  @override
  String toString() => ")";

  @override
  int get precendece => 5;

  @override
  ParenthesesKind get kind => ParenthesesKind.close;

  @override
  void mutateToPostfix(
    IToken token,
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    while (operatorStack.isNotEmpty && operatorStack.top is! OpenParentheses) {
      postfix.push(operatorStack.pop());
    }

    if (operatorStack.isNotEmpty && operatorStack.top is OpenParentheses) {
      operatorStack.pop();
    }
  }
}
