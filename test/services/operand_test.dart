import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/operator.dart';
import 'package:pascaline_scientific_calculator/services/operand.dart';

void main() {
  group('Operand', () {
    test('should parse valid numeric string', () {
      final operand = Operand('42');

      expect(operand.isValid, isTrue);
      expect(operand.toNum, equals(42));
      expect(operand.toString(), equals('42'));
    });

    test('should parse valid decimal string', () {
      final operand = Operand('3.14');

      expect(operand.isValid, isTrue);
      expect(operand.toNum, equals(3.14));
      expect(operand.toString(), equals('3.14'));
    });

    test('should handle invalid numeric string', () {
      final operand = Operand('abc');

      expect(operand.isValid, isFalse);
      expect(operand.toNum, equals(0));
      expect(operand.toString(), equals(''));
    });

    test('mutateToPostfix should push itself to postfix stack', () {
      final operand = Operand('5');
      final List<IToken> postfix = [];
      final List<IOperator> operatorStack = [];

      operand.mutateToPostfix(operand, postfix, operatorStack);

      expect(postfix.length, equals(1));
      expect(postfix.last, equals(operand));
      expect(operatorStack.length, equals(0));
    });
  });
}
