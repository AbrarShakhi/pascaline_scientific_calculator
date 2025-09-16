import 'exp_stack.dart';

import 'operand.dart';
import 'operator.dart';
import 'token.dart';

enum ExpressionKind { infix, postfix }

abstract class IExpression {
  ExpressionKind get kind;
  num evaluate();
}

class InfixExpression implements IExpression {
  final ExpressionStack<IToken> _infix = ExpressionStack<IToken>();

  @override
  String toString() => _infix.toString();

  @override
  ExpressionKind get kind => ExpressionKind.infix;

  @override
  num evaluate() {
    throw Exception("You can not evaluate Infix expression.");
  }
}

class PostExpression implements IExpression {
  final ExpressionStack<IToken> _postfix = ExpressionStack<IToken>();

  @override
  String toString() => _postfix.toString();

  @override
  ExpressionKind get kind => ExpressionKind.postfix;

  @override
  num evaluate() {
    final ExpressionStack<num> results = ExpressionStack<num>();

    for (var token in _postfix.items) {
      if (!token.isOperator) {
        final operator_ = token as IOperator;

        if (!token.isArithmetic) {
          throw Exception("Invalid Operator '${operator_.toString()}'.");
        }
        if (results.length < 2) {
          throw Exception(
            "Insufficient operands for operator '${operator_.toString()}'.",
          );
        }

        final right = results.pop();
        final left = results.pop();

        results.push(operator_.action(left, right));
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
}
