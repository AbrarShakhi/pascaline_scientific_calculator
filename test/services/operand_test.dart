import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/operator.dart';
import 'package:pascaline_scientific_calculator/services/operand.dart';

void main() {
  group('Operand', () {
    test('should parse valid numeric string', () {
      final operand = Operand.fromString('42');

      expect(operand.isValid, isTrue);
      expect(operand.toNum, equals(42));
      expect(operand.toString(), equals('42'));
    });

    test('should parse valid decimal string', () {
      final operand = Operand.fromString('3.14');

      expect(operand.isValid, isTrue);
      expect(operand.toNum, equals(3.14));
      expect(operand.toString(), equals('3.14'));
    });

    test('should handle invalid numeric string', () {
      final operand = Operand.fromString('abc');

      expect(operand.isValid, isFalse);
      expect(operand.toNum, equals(0));
      expect(operand.toString(), equals(''));
    });

    test('should parse empty string', () {
      final operand = Operand.fromString('');

      expect(operand.isValid, isTrue);
      expect(operand.toNum, equals(0));
      expect(operand.toString(), equals('0'));
    });

    test('should parse valid numeric list', () {
      final operand = Operand.fromList([50, 51]);

      expect(operand.isValid, isTrue);
      expect(operand.toNum, equals(23));
      expect(operand.toString(), equals('23'));
    });

    test('should parse valid decimal list', () {
      final operand = Operand.fromList([49, 46, 53]);

      expect(operand.isValid, isTrue);
      expect(operand.toNum, equals(1.5));
      expect(operand.toString(), equals('1.5'));
    });

    test('should handle invalid numeric list', () {
      final operand = Operand.fromList([100, 101]);

      expect(operand.isValid, isFalse);
      expect(operand.toNum, equals(0));
      expect(operand.toString(), equals(''));
    });

    test('should parse empty list', () {
      final operand = Operand.fromList([]);

      expect(operand.isValid, isTrue);
      expect(operand.toNum, equals(0));
      expect(operand.toString(), equals('0'));
    });

    test('mutateToPostfix should push itself to postfix stack', () {
      final operand = Operand.fromString('5');
      final List<IToken> postfix = [];
      final List<IOperator> operatorStack = [];

      operand.mutateToPostfix(operand, postfix, operatorStack);

      expect(postfix.length, equals(1));
      expect(postfix.last, equals(operand));
      expect(operatorStack.length, equals(0));
    });
  });
}
