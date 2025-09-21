import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/operator.dart';

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
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    // Example behavior for testing
    operatorStack.add(this);
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
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    postfix.add(token);
  }
}

void main() {
  group('Operator Tests', () {
    test('Operator precedence should return correct value', () {
      final operator_ = MockOperator(5);

      expect(operator_.precendece, 5);
    });

    test('Operator evaluteAction should perform correct operation', () {
      final operator_ = MockOperator(1);

      expect(operator_.evaluteAction(3, 4), 7); // 3 + 4 = 7
    });

    test('mutateToPostfix should push operator to the operator stack', () {
      final operator_ = MockOperator(1);
      final List<IToken> postfix = [];
      final List<IOperator> operatorStack = [];

      operator_.mutateToPostfix(MockToken(), postfix, operatorStack);

      expect(operatorStack.length, 1);
      expect(operatorStack.last.precendece, 1); // Ensure the operator is pushed
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
      final List<IToken> postfix = [];
      final List<IOperator> operatorStack = [];

      token.mutateToPostfix(token, postfix, operatorStack);

      expect(postfix.length, 1);
      expect(
        postfix.last,
        token,
      ); // The token should be pushed to postfix stack
    });
  });
}
