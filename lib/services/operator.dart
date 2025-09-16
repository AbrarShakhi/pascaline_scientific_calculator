import 'token.dart';

abstract class IOperator implements IToken {
  int get precendece;
  num action(num left, num right);
  bool get isArithmetic;
}
