import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/operator.dart';
import 'package:pascaline_scientific_calculator/services/stack_list.dart';

// Mock operator implementation
class MockOperator implements IOperator {
  final int precedence;
  MockOperator(this.precedence);

  @override
  int get precendece => precedence;

  @override
  num evaluteAction(num left, num right) {
    // Simple operation, for example, addition
    return left + right;
  }

  @override
  void mutateToPostfix(
    IToken token,
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    // Example behavior for testing
    operatorStack.push(this);
  }
}

// Mock parentheses implementation
class MockParentheses implements Parentheses {
  @override
  ParenthesesKind get kind => ParenthesesKind.open;
}

// A simple implementation of IToken to use for testing
class MockToken implements IToken {
  @override
  void mutateToPostfix(
    IToken token,
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    postfix.push(token);
  }
}

void main() {
  group('Operator Tests', () {
    test('Operator precedence should return correct value', () {
      final operator = MockOperator(5);

      expect(operator.precendece, 5);
    });

    test('Operator evaluteAction should perform correct operation', () {
      final operator = MockOperator(1);

      expect(operator.evaluteAction(3, 4), 7); // 3 + 4 = 7
    });

    test('mutateToPostfix should push operator to the operator stack', () {
      final operator = MockOperator(1);
      final postfix = StackList<IToken>();
      final operatorStack = StackList<IOperator>();

      operator.mutateToPostfix(MockToken(), postfix, operatorStack);

      expect(operatorStack.length, 1);
      expect(operatorStack.top.precendece, 1); // Ensure the operator is pushed
    });
  });

  group('Parentheses Tests', () {
    test('Parentheses should return correct kind', () {
      final parentheses = MockParentheses();

      expect(parentheses.kind, ParenthesesKind.open);
    });
  });

  group('IToken mutateToPostfix Tests', () {
    test('mutateToPostfix should add token to postfix stack', () {
      final token = MockToken();
      final postfix = StackList<IToken>();
      final operatorStack = StackList<IOperator>();

      token.mutateToPostfix(token, postfix, operatorStack);

      expect(postfix.length, 1);
      expect(postfix.top, token); // The token should be pushed to postfix stack
    });
  });
}
