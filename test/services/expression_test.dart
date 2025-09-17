import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/expression.dart';
import 'package:pascaline_scientific_calculator/services/operand.dart';
import 'package:pascaline_scientific_calculator/services/operations.dart';

void main() {
  group('InfixExpression', () {
    test('addToken and removeToken work as expected', () {
      final expr = InfixExpression();
      final operand = Operand('5');

      expr.addToken(operand);
      expect(expr.isEmpty, isFalse);
      expect(expr.length, 1);
      expect(expr.last, operand);
      final removed = expr.removeToken();
      expect(removed, operand);
      expect(expr.isEmpty, isTrue);
    });

    test('toPostfix converts infix to correct postfix order', () {
      final expr = InfixExpression();

      // Infix: 2 + 3
      expr.addToken(Operand('2'));
      expr.addToken(Addition());
      expr.addToken(Operand('3'));

      final postfix = expr.toPostfix();
      final postfixTokens = postfix.items;

      // Should be: 2 3 +
      expect(postfixTokens.length, 3);
      expect(postfixTokens[0].toString(), '2');
      expect(postfixTokens[1].toString(), '3');
      expect(postfixTokens[2].toString(), '+');
    });

    test('toString returns correct infix string', () {
      final expr = InfixExpression();
      expr.addToken(Operand('4'));
      expr.addToken(Multiplication());
      expr.addToken(Operand('5'));

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
      infix.addToken(Operand('3'));
      infix.addToken(Addition());
      infix.addToken(Operand('4'));
      infix.addToken(Multiplication());
      infix.addToken(Operand('2'));

      final post = PostExpression(infix);
      final result = post.evaluate();
      expect(result, equals(11)); // 3 + (4 * 2)
    });

    test('evaluate supports exponentiation', () {
      final infix = InfixExpression();
      infix.addToken(Operand('2'));
      infix.addToken(Exponentiation());
      infix.addToken(Operand('3')); // 2^3 = 8

      final post = PostExpression(infix);
      expect(post.evaluate(), equals(8));
    });

    test('evaluate with invalid operand throws exception', () {
      final infix = InfixExpression();
      infix.addToken(Operand('abc')); // invalid

      final expr = PostExpression(infix);

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
      infix.addToken(Addition()); // No operands

      final expr = PostExpression(infix);

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
      infix.addToken(OpenParentheses());

      final expr = PostExpression(infix);

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
      infix.addToken(Operand('2'));
      infix.addToken(Operand('3')); // Missing operator

      final expr = PostExpression(infix);

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
      infix.addToken(Operand('1'));
      infix.addToken(Operand('2'));
      infix.addToken(Addition());

      final expr = PostExpression(infix);

      // Postfix: 1 2 + => toString reverses: "+21"
      expect(expr.toString(), equals('+21'));
    });
  });
}
