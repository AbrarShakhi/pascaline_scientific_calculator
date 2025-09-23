class ExpressionHelpers {
  static bool isZero(String str) {
    if (str.isEmpty) {
      return true;
    }

    final parsedNum = num.tryParse(str);

    if (parsedNum != null && parsedNum == 0) {
      return true;
    } else {
      return false;
    }
  }
}
