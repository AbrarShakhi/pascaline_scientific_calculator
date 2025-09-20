class StackList<E> {
  final List<E> _storage = [];

  void push(E element) => _storage.add(element);
  E pop() => _storage.removeLast();
  void clear() => _storage.clear();
  E get top => _storage.last;
  bool get isEmpty => _storage.isEmpty;
  bool get isNotEmpty => _storage.isNotEmpty;
  int get length => _storage.length;

  @override
  String toString() => _storage.toString();

  List<E> get items => List.unmodifiable(_storage);
}
