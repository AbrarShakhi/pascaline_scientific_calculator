import 'operator.dart';

class Operand implements IToken {
  final num? _value;
  final bool _isValid;

  Operand._(this._value, this._isValid);

  factory Operand.fromString(String inputString) {
    if (inputString.isEmpty) {
      return Operand._(0, true);
    }
    final parsedValue = num.tryParse(inputString);
    return Operand._(parsedValue, parsedValue != null);
  }

  factory Operand.fromList(List<int> inputList) {
    final stringBuffer = StringBuffer();
    for (final charCode in inputList) {
      stringBuffer.writeCharCode(charCode);
    }
    return Operand.fromString(stringBuffer.toString());
  }

  bool get isValid => _isValid;
  num get toNum => (_value != null) ? _value : 0;

  @override
  String toString() => (_isValid) ? _value.toString() : '';

  @override
  void mutateToPostfix(
    IToken token,
    List<IToken> postfix,
    List<IOperator> operatorStack,
  ) {
    postfix.add(token as Operand);
  }
}
