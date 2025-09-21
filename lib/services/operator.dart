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
}

enum ParenthesesKind { open, close }

abstract class Parentheses {
  ParenthesesKind get kind;
}
