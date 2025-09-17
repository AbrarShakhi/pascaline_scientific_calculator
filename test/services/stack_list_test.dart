import 'package:flutter_test/flutter_test.dart';
import 'package:pascaline_scientific_calculator/services/stack_list.dart';

void main() {
  group('StackList Tests', () {
    late StackList<int> stack;

    // Set up a fresh stack for each test
    setUp(() {
      stack = StackList<int>();
    });

    test('isEmpty should return true for a new stack', () {
      expect(stack.isEmpty, isTrue);
    });

    test('isNotEmpty should return false for a new stack', () {
      expect(stack.isNotEmpty, isFalse);
    });

    test('push should add an element to the stack', () {
      stack.push(1);
      expect(stack.isEmpty, isFalse);
      expect(stack.length, equals(1));
      expect(stack.top, equals(1));
    });

    test('pop should remove and return the last element', () {
      stack.push(1);
      stack.push(2);

      expect(stack.pop(), equals(2));
      expect(stack.length, equals(1));
      expect(stack.top, equals(1));
    });

    test('pop should throw an exception if the stack is empty', () {
      expect(() => stack.pop(), throwsA(isA<RangeError>()));
    });

    test('top should return the last element without removing it', () {
      stack.push(1);
      stack.push(2);

      expect(stack.top, equals(2)); // Should return 2 without removing it
      expect(stack.length, equals(2)); // Length should stay the same
    });

    test('toString should return a string representation of the stack', () {
      stack.push(1);
      stack.push(2);

      expect(stack.toString(), equals('[1, 2]'));
    });

    test('items should return an unmodifiable list of stack elements', () {
      stack.push(1);
      stack.push(2);

      // Check the items list
      expect(stack.items, equals([1, 2]));
      expect(() => stack.items.add(3), throwsA(isA<UnsupportedError>()));
    });
  });
}
