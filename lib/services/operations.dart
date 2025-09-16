import 'dart:math';

import 'operator.dart';

class Addition implements IOperator {
  @override
  num action(num left, num right) => left + right;

  @override
  bool get isArithmetic => true;

  @override
  String toString() => "+";

  @override
  int get precendece => 1;

  @override
  bool get isOperator => true;
}

class Substraction implements IOperator {
  @override
  num action(num left, num right) => left - right;

  @override
  bool get isArithmetic => true;

  @override
  String toString() => "-";

  @override
  int get precendece => 1;

  @override
  bool get isOperator => true;
}

class Multiplication implements IOperator {
  @override
  num action(num left, num right) => left * right;

  @override
  bool get isArithmetic => true;

  @override
  String toString() => "*";

  @override
  int get precendece => 2;

  @override
  bool get isOperator => true;
}

class Division implements IOperator {
  @override
  num action(num left, num right) => left / right;

  @override
  bool get isArithmetic => true;

  @override
  String toString() => "/";

  @override
  int get precendece => 2;

  @override
  bool get isOperator => true;
}

class Exponentiation implements IOperator {
  @override
  num action(num left, num right) => pow(left, right);

  @override
  bool get isArithmetic => true;

  @override
  String toString() => "^";

  @override
  int get precendece => 3;

  @override
  bool get isOperator => true;
}

class OpenParentheses implements IOperator {
  @override
  num action(num left, num right) => 0;

  @override
  bool get isArithmetic => false;
  @override
  String toString() => "(";

  @override
  int get precendece => 0;

  @override
  bool get isOperator => true;
}

class CloseParentheses implements IOperator {
  @override
  num action(num left, num right) => 0;

  @override
  bool get isArithmetic => false;

  @override
  String toString() => ")";

  @override
  int get precendece => 5;

  @override
  bool get isOperator => true;
}
