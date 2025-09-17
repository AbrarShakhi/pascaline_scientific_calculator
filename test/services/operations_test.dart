import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/operator.dart';
import 'package:pascaline_scientific_calculator/services/stack_list.dart';
import 'package:pascaline_scientific_calculator/services/operations.dart';

void main() {
  group('Operator Evaluation', () {
    test('Addition evaluteAction returns correct sum', () {
      final op = Addition();
      expect(op.evaluteAction(2, 3), equals(5));
    });

    test('Substraction evaluteAction returns correct difference', () {
      final op = Substraction();
      expect(op.evaluteAction(5, 3), equals(2));
    });

    test('Multiplication evaluteAction returns correct product', () {
      final op = Multiplication();
      expect(op.evaluteAction(2, 4), equals(8));
    });

    test('Division evaluteAction returns correct quotient', () {
      final op = Division();
      expect(op.evaluteAction(10, 2), equals(5));
    });

    test('Exponentiation evaluteAction returns correct power', () {
      final op = Exponentiation();
      expect(op.evaluteAction(2, 3), equals(8));
    });
  });

  group('Operator Precedence', () {
    test('Addition and Subtraction precedence should be 1', () {
      expect(Addition().precendece, 1);
      expect(Substraction().precendece, 1);
    });

    test('Multiplication and Division precedence should be 2', () {
      expect(Multiplication().precendece, 2);
      expect(Division().precendece, 2);
    });

    test('Exponentiation precedence should be 3', () {
      expect(Exponentiation().precendece, 3);
    });

    test('OpenParentheses precedence should be 0', () {
      expect(OpenParentheses().precendece, 0);
    });

    test('CloseParentheses precedence should be 5', () {
      expect(CloseParentheses().precendece, 5);
    });
  });

  group('mutateToPostfix Logic', () {
    test('Addition pushes to empty operator stack', () {
      final postfix = StackList<IToken>();
      final operatorStack = StackList<IOperator>();
      final addition = Addition();

      addition.mutateToPostfix(addition, postfix, operatorStack);

      expect(postfix.isEmpty, isTrue);
      expect(operatorStack.top, addition);
    });

    test('Addition pops lower precedence operator from stack', () {
      final postfix = StackList<IToken>();
      final operatorStack = StackList<IOperator>();
      final mult = Multiplication();
      final add = Addition();

      operatorStack.push(mult); // Multiplication has higher precedence

      add.mutateToPostfix(add, postfix, operatorStack);

      expect(postfix.top, mult);
      expect(operatorStack.top, add);
    });

    test('CloseParentheses pops until OpenParentheses', () {
      final postfix = StackList<IToken>();
      final operatorStack = StackList<IOperator>();

      final open = OpenParentheses();
      final add = Addition();
      final close = CloseParentheses();

      operatorStack.push(open);
      operatorStack.push(add);

      close.mutateToPostfix(close, postfix, operatorStack);

      expect(postfix.top, add);
      expect(operatorStack.isEmpty, isTrue);
    });
  });

  group('Parentheses Type', () {
    test('OpenParentheses kind should be open', () {
      final open = OpenParentheses();
      expect(open.kind, ParenthesesKind.open);
    });

    test('CloseParentheses kind should be close', () {
      final close = CloseParentheses();
      expect(close.kind, ParenthesesKind.close);
    });
  });
}
