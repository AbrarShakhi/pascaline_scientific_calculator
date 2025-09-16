import 'token.dart';

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
  bool get isOperator => false;

  @override
  String toString() => (_isValid) ? _value.toString() : '';
}
