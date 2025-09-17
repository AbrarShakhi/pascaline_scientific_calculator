import 'stack_list.dart';
import 'operand.dart';
import 'operator.dart';

enum ExpressionKind { infix, postfix }

abstract class IExpression {
  ExpressionKind get kind;
  num evaluate();
  void addToken(IToken tok);
  IToken removeToken();
  bool get isEmpty;
  int get length;
  List<IToken> get items;
}

class InfixExpression implements IExpression {
  final StackList<IToken> _infix = StackList<IToken>();

  @override
  ExpressionKind get kind => ExpressionKind.infix;

  @override
  num evaluate() {
    throw Exception("You can not evaluate Infix expression.");
  }

  @override
  void addToken(IToken tok) => _infix.push(tok);

  @override
  IToken removeToken() => _infix.pop();

  @override
  bool get isEmpty => _infix.isEmpty;

  @override
  int get length => _infix.length;

  @override
  String toString() {
    var stringBuffer = StringBuffer();
    for (var token in _infix.items) {
      stringBuffer.write(token.toString());
    }
    return stringBuffer.toString();
  }

  @override
  List<IToken> get items => _infix.items;

  StackList<IToken> toPostfix() {
    final postfix = StackList<IToken>();
    final operatorStack = StackList<IOperator>();

    for (var token in _infix.items) {
      token.mutateToPostfix(token, postfix, operatorStack);
    }

    while (operatorStack.isNotEmpty) {
      postfix.push(operatorStack.pop());
    }

    return postfix;
  }
}

class PostExpression implements IExpression {
  final StackList<IToken> _postfix;

  PostExpression._(this._postfix);

  factory PostExpression(InfixExpression infix) {
    return PostExpression._(infix.toPostfix());
  }

  @override
  ExpressionKind get kind => ExpressionKind.postfix;

  @override
  num evaluate() {
    final StackList<num> results = StackList<num>();

    for (var token in _postfix.items) {
      if (token is IOperator) {
        final operator_ = token;

        if (token is Parentheses) {
          throw Exception("Invalid Operator '${operator_.toString()}'.");
        }
        if (results.length < 2) {
          throw Exception(
            "Insufficient operands for operator '${operator_.toString()}'.",
          );
        }

        final right = results.pop();
        final left = results.pop();

        results.push(operator_.evaluteAction(left, right));
      } else {
        final operand = token as Operand;
        if (!operand.isValid) {
          throw Exception("Invalid operand found.");
        }
        results.push(operand.toNum);
      }
    }
    if (results.length != 1) {
      throw Exception("Invalid postfix expression.");
    }
    return results.top;
  }

  @override
  void addToken(IToken tok) => _postfix.push(tok);

  @override
  IToken removeToken() => _postfix.pop();

  @override
  bool get isEmpty => _postfix.isEmpty;

  @override
  int get length => _postfix.length;

  @override
  String toString() {
    var stringBuffer = StringBuffer();
    for (var token in _postfix.items.reversed) {
      stringBuffer.write(token.toString());
    }
    return stringBuffer.toString();
  }

  @override
  List<IToken> get items => _postfix.items;
}
