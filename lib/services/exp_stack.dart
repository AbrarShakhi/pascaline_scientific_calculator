class ExpressionStack<E> {
  final List<E> _storage = [];

  void push(E element) => _storage.add(element);
  E pop() => _storage.removeLast();
  E get top => _storage.last;
  bool get isEmpty => _storage.isEmpty;
  int get length => _storage.length;

  @override
  String toString() {
    // TODO: Return a valid string
    return _storage.toString();
  }

  List<E> get items => List.unmodifiable(_storage);
}
