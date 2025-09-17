import 'stack_list.dart';

import 'operator.dart';

class Operand implements IToken {
  final num? _value;
  final bool _isValid;

  Operand._(this._value, this._isValid);

  factory Operand(String input) {
    final parsedValue = num.tryParse(input);
    return Operand._(parsedValue, parsedValue != null);
  }

  bool get isValid => _isValid;
  num get toNum => (_value != null) ? _value : 0;

  @override
  String toString() => (_isValid) ? _value.toString() : '';

  @override
  void mutateToPostfix(
    IToken token,
    StackList<IToken> postfix,
    StackList<IOperator> operatorStack,
  ) {
    postfix.push(token as Operand);
  }
}
