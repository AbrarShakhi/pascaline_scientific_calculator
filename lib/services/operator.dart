import 'operations.dart';

abstract class IToken {
  void mutateToPostfix(
    IToken token,
    List<IToken> postfix,
    List<IOperator> operatorStack,
  );
}

abstract class IOperator implements IToken {
  int get precendece;
  num evaluteAction(num left, num right);

  factory IOperator.findChild(int op) {
    switch (String.fromCharCode(op)) {
      case '+':
        return Addition();
      case '-':
        return Substraction();
      case '*':
        return Multiplication();
      case '/':
        return Division();
      case '^':
        return Exponentiation();
      case '(':
        return OpenParentheses();
      case ')':
        return CloseParentheses();
      default:
        throw Exception("Provided operator is not an valid operator, $op");
    }
  }
}

enum ParenthesesKind { open, close }

abstract class Parentheses {
  ParenthesesKind get kind;
}
