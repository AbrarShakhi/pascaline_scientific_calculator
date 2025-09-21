import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/expression.dart';
import 'package:pascaline_scientific_calculator/services/operand.dart';
import 'package:pascaline_scientific_calculator/services/operations.dart';

void main() {
  group('InfixExpression', () {
    test('addToken and removeToken work as expected', () {
      final expr = InfixExpression();
      final operand = Operand('5');

      expr.pushToken(operand);
      expect(expr.isEmpty, isFalse);
      expect(expr.length, 1);
      expect(expr.last, operand);
      final removed = expr.popToken();
      expect(removed, operand);
      expect(expr.isEmpty, isTrue);
    });

    test('toPostfix converts infix to correct postfix order', () {
      final expr = InfixExpression();

      // Infix: 2 + 3
      expr.pushToken(Operand('2'));
      expr.pushToken(Addition());
      expr.pushToken(Operand('3'));

      final postfix = expr.toPostfix();
      final postfixTokens = postfix;

      // Should be: 2 3 +
      expect(postfixTokens.length, 3);
      expect(postfixTokens[0].toString(), '2');
      expect(postfixTokens[1].toString(), '3');
      expect(postfixTokens[2].toString(), '+');
    });

    test('toString returns correct infix string', () {
      final expr = InfixExpression();
      expr.pushToken(Operand('4'));
      expr.pushToken(Multiplication());
      expr.pushToken(Operand('5'));

      expect(expr.toString(), '4*5');
    });

    test('evaluate throws exception for InfixExpression', () {
      final expr = InfixExpression();
      expect(() => expr.evaluate(), throwsException);
    });
  });

  group('PostExpression', () {
    test('evaluate returns correct result for simple expression', () {
      final infix = InfixExpression();
      infix.pushToken(Operand('3'));
      infix.pushToken(Addition());
      infix.pushToken(Operand('4'));
      infix.pushToken(Multiplication());
      infix.pushToken(Operand('2'));

      final post = PostfixExpression(infix);
      final result = post.evaluate();
      expect(result, equals(11)); // 3 + (4 * 2)
    });

    test('evaluate supports exponentiation', () {
      final infix = InfixExpression();
      infix.pushToken(Operand('2'));
      infix.pushToken(Exponentiation());
      infix.pushToken(Operand('3')); // 2^3 = 8

      final post = PostfixExpression(infix);
      expect(post.evaluate(), equals(8));
    });

    test('evaluate with invalid operand throws exception', () {
      final infix = InfixExpression();
      infix.pushToken(Operand('abc')); // invalid

      final expr = PostfixExpression(infix);

      expect(
        () => expr.evaluate(),
        throwsA(
          predicate(
            (e) => e is Exception && e.toString().contains('Invalid operand'),
          ),
        ),
      );
    });

    test('evaluate with insufficient operands throws exception', () {
      final infix = InfixExpression();
      infix.pushToken(Addition()); // No operands

      final expr = PostfixExpression(infix);

      expect(
        () => expr.evaluate(),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains('Insufficient operands'),
          ),
        ),
      );
    });

    test('evaluate with parentheses throws exception', () {
      final infix = InfixExpression();
      infix.pushToken(OpenParentheses());

      final expr = PostfixExpression(infix);

      expect(
        () => expr.evaluate(),
        throwsA(
          predicate(
            (e) => e is Exception && e.toString().contains('Invalid Operator'),
          ),
        ),
      );
    });

    test('evaluate with leftover stack throws exception', () {
      final infix = InfixExpression();
      infix.pushToken(Operand('2'));
      infix.pushToken(Operand('3')); // Missing operator

      final expr = PostfixExpression(infix);

      expect(
        () => expr.evaluate(),
        throwsA(
          predicate(
            (e) => e is Exception && e.toString().contains('Invalid postfix'),
          ),
        ),
      );
    });

    test('toString returns correct postfix string', () {
      final infix = InfixExpression();
      infix.pushToken(Operand('1'));
      infix.pushToken(Operand('2'));
      infix.pushToken(Addition());

      final expr = PostfixExpression(infix);

      // Postfix: 1 2 + => toString reverses: "+21"
      expect(expr.toString(), equals('+21'));
    });
  });
}
