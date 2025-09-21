import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/expression_manager.dart';
import 'package:pascaline_scientific_calculator/services/operand.dart';
import 'package:pascaline_scientific_calculator/services/operations.dart';
import 'package:pascaline_scientific_calculator/services/operator.dart';

void main() {
  group('ExpressionManager Tests', () {
    test('should parse a simple infix expression correctly', () {
      final manager = ExpressionManager();

      manager.parseInfix('3+4');

      final expression = manager.expression;

      expect(expression.isNotEmpty, true);
      expect(expression.length, 3);

      expect(expression[1], isA<Addition>());
    });

    test('should throw error if expression is already parsed', () {
      final manager = ExpressionManager();

      manager.parseInfix('3+4');

      expect(manager.isParsed, isTrue);
      expect(() => manager.parseInfix('5+6'), throwsException);
    });

    test('clear() should reset the state', () {
      final manager = ExpressionManager();

      manager.parseInfix('3+4');

      manager.clear();
      expect(manager.isParsed, isFalse);
    });

    test('should handle a complex infix expression', () {
      final manager = ExpressionManager();

      expect(() => manager.parseInfix('3+(4.3*2)'), returnsNormally);
      expect(manager.isParsed, true);

      List<IToken> expected = List.unmodifiable([
        Operand.fromString('3'),
        Addition(),
        OpenParentheses(),
        Operand.fromString('4.3'),
        Multiplication(),
        Operand.fromString('2'),
        CloseParentheses(),
      ]);

      expect(manager.expression.length, expected.length);

      for (var i = 0; i < expected.length; i++) {
        expect(manager.expression[i].toString(), expected[i].toString());
      }
    });

    test('should calculate the result of the expression', () {
      final manager = ExpressionManager();

      manager.parseInfix('3+(4.3*2)*3');
      final result = manager.calculate();

      expect(result, 28.799999999999997);
    });

    test('should pass invalid characters in expression', () {
      final manager = ExpressionManager();

      expect(() => manager.parseInfix('3+4@2'), returnsNormally);
    });

    test('should pass unbalanced parentheses', () {
      final manager = ExpressionManager();

      expect(() => manager.parseInfix('3+(4*2'), returnsNormally);
    });

    test('should handle invalid characters calculation', () {
      final manager = ExpressionManager();

      manager.parseInfix('3+4@2');
      expect(
        () => manager.calculate(),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains('Invalid operand found'),
          ),
        ),
      );
    });

    test('should handle unbalanced parentheses', () {
      final manager = ExpressionManager();

      manager.parseInfix('3+(4*2');
      expect(
        () => manager.calculate(),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains("Invalid Operator '('."),
          ),
        ),
      );
    });
  });
}
