import 'operand.dart';
import 'operator.dart';

enum ExpressionKind { infix, postfix }

abstract class IExpression {
  ExpressionKind get kind;
  num evaluate();
  void pushToken(IToken tok);
  IToken popToken();
  void clear();
  bool get isEmpty;
  bool get isNotEmpty;
  int get length;
  List<IToken> get items;
  IToken get last;
}

class InfixExpression implements IExpression {
  final List<IToken> _infix;

  InfixExpression._(this._infix);

  factory InfixExpression() {
    return InfixExpression._([]);
  }

  factory InfixExpression.infix(List<IToken> infix) {
    return InfixExpression._(infix);
  }

  @override
  ExpressionKind get kind => ExpressionKind.infix;

  @override
  num evaluate() {
    throw Exception("You can not evaluate Infix expression.");
  }

  @override
  void pushToken(IToken tok) => _infix.add(tok);

  @override
  IToken popToken() => _infix.removeLast();

  @override
  void clear() => _infix.clear();

  @override
  bool get isEmpty => _infix.isEmpty;

  @override
  bool get isNotEmpty => _infix.isNotEmpty;

  @override
  int get length => _infix.length;

  @override
  String toString() {
    var stringBuffer = StringBuffer();
    for (var token in _infix) {
      stringBuffer.write(token.toString());
    }
    return stringBuffer.toString();
  }

  @override
  List<IToken> get items => List.unmodifiable(_infix);

  @override
  IToken get last => _infix.last;

  List<IToken> toPostfix() {
    List<IToken> postfix = [];
    List<IOperator> operatorStack = [];

    for (var token in _infix) {
      token.mutateToPostfix(token, postfix, operatorStack);
    }

    while (operatorStack.isNotEmpty) {
      postfix.add(operatorStack.removeLast());
    }

    return postfix;
  }
}

class PostfixExpression implements IExpression {
  final List<IToken> _postfix;

  PostfixExpression._(this._postfix);

  factory PostfixExpression(InfixExpression infix) {
    return PostfixExpression._(infix.toPostfix());
  }

  @override
  ExpressionKind get kind => ExpressionKind.postfix;

  @override
  num evaluate() {
    final List<num> results = [];

    for (var token in _postfix) {
      if (token is IOperator) {
        final operator_ = token;

        if (operator_ is Parentheses) {
          throw Exception("Invalid Operator '${operator_.toString()}'.");
        }
        if (results.length < 2) {
          throw Exception(
            "Insufficient operands for operator '${operator_.toString()}'.",
          );
        }

        final right = results.removeLast();
        final left = results.removeLast();

        results.add(operator_.evaluteAction(left, right));
      } else if (token is Operand) {
        final operand = token;
        if (!operand.isValid) {
          throw Exception("Invalid operand found.");
        }
        results.add(operand.toNum);
      } else {
        throw Exception(
          "token has to be either 'Operand' or 'IOperator'. this block should not run.",
        );
      }
    }
    if (results.length != 1) {
      throw Exception("Invalid postfix expression.");
    }
    return results.last;
  }

  @override
  void pushToken(IToken tok) => _postfix.add(tok);

  @override
  IToken popToken() => _postfix.removeLast();

  @override
  void clear() => _postfix.clear();

  @override
  bool get isEmpty => _postfix.isEmpty;

  @override
  bool get isNotEmpty => _postfix.isNotEmpty;

  @override
  int get length => _postfix.length;

  @override
  String toString() {
    var stringBuffer = StringBuffer();
    for (var token in _postfix.reversed) {
      stringBuffer.write(token.toString());
    }
    return stringBuffer.toString();
  }

  @override
  List<IToken> get items => List.unmodifiable(_postfix);

  @override
  IToken get last => _postfix.last;
}
