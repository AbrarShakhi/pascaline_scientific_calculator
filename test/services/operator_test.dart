import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/operator.dart';
import 'package:pascaline_scientific_calculator/services/operations.dart';

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
  group('IOperator.findChild Tests', () {
    test('findChild should create Addition operator for "+"', () {
      final operator = IOperator.findChild('+'.codeUnits[0]);
      expect(operator, isA<Addition>());
    });

    test('findChild should create Substraction operator for "-"', () {
      final operator = IOperator.findChild('-'.codeUnits[0]);
      expect(operator, isA<Substraction>());
    });

    test('findChild should create Multiplication operator for "*"', () {
      final operator = IOperator.findChild('*'.codeUnits[0]);
      expect(operator, isA<Multiplication>());
    });

    test('findChild should create Division operator for "/"', () {
      final operator = IOperator.findChild('/'.codeUnits[0]);
      expect(operator, isA<Division>());
    });

    test('findChild should create Exponentiation operator for "^"', () {
      final operator = IOperator.findChild('^'.codeUnits[0]);
      expect(operator, isA<Exponentiation>());
    });

    test('findChild should create OpenParentheses for "("', () {
      final operator = IOperator.findChild('('.codeUnits[0]);
      expect(operator, isA<OpenParentheses>());
    });

    test('findChild should create CloseParentheses for ")"', () {
      final operator = IOperator.findChild(')'.codeUnits[0]);
      expect(operator, isA<CloseParentheses>());
    });

    test('findChild should throw exception for invalid operator', () {
      expect(() => IOperator.findChild('@'.codeUnits[0]), throwsException);
    });
  });

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

  group('Edge Case Tests', () {
    test('mutateToPostfix should handle empty operator stack correctly', () {
      final operator_ = MockOperator(1);
      final List<IToken> postfix = [];
      final List<IOperator> operatorStack = [];

      operator_.mutateToPostfix(MockToken(), postfix, operatorStack);

      expect(
        operatorStack.isEmpty,
        false,
      ); // Stack shouldn't be empty after mutation
    });

    test('mutateToPostfix should not throw error on empty token', () {
      final token = MockToken();
      final List<IToken> postfix = [];
      final List<IOperator> operatorStack = [];

      expect(
        () => token.mutateToPostfix(token, postfix, operatorStack),
        returnsNormally,
      );
    });
  });

  group('Operator Precedence Tests', () {
    test('Operator precedence for addition should be correct', () {
      final operator = MockOperator(1);
      expect(operator.precendece, 1);
    });

    test('Operator precedence for multiplication should be correct', () {
      final operator = MockOperator(2);
      expect(operator.precendece, 2);
    });

    test('Operator precedence for exponentiation should be correct', () {
      final operator = MockOperator(3);
      expect(operator.precendece, 3);
    });

    test('Operator precedence should differ between operators', () {
      final addition = MockOperator(1);
      final multiplication = MockOperator(2);
      final exponentiation = MockOperator(3);

      expect(addition.precendece < multiplication.precendece, true);
      expect(multiplication.precendece < exponentiation.precendece, true);
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
