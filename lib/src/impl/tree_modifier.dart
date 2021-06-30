import '../bs4_element.dart';

abstract class TreeModifierImpl {
  /// {@macro bs4element_string}
  set string(String? value);

  /// Adds an element just before the closing tags of the current element.
  void append(Bs4Element element);

  /// Adds elements just before the closing tags of the current element,
  /// in order.
  void extend(List<Bs4Element> element);

  void _newTag();

  /// It is just like [_append], except the new element does not necessarily
  /// go at the end of its parent’s .contents. It’ll be inserted at
  /// whatever numeric position you say, just after the opening tag of the
  /// current element.
  ///
  /// If the position is out of range, throws [RangeError].
  void insert(int position, Bs4Element element);

  /// Inserts an element immediately before the current element in
  /// the parse tree.
  ///
  /// [ref] specifies an position of an element, where should the insertion
  /// apply.
  ///
  /// If the [ref] is not in the parse tree, throws [RangeError].
  void insertBefore(Bs4Element element, [Bs4Element? ref]);

  /// Inserts an element immediately following the element in the parse tree.
  ///
  /// Without [ref] argument it acts just like the [append] method.
  ///
  /// [ref] specifies an position of an element, where should the insertion
  /// apply.
  ///
  /// If the [ref] is not in the parse tree, throws [RangeError].
  void insertAfter(Bs4Element element, [Bs4Element? ref]);

  void _clear();

  /// Removes an element from the tree.
  ///
  /// Returns the element that was extracted.
  Bs4Element extract();

  void _decompose();

  /// Removes an element from the tree, and replaces it with [otherElement].
  ///
  /// Returns the element that was replaced.
  Bs4Element replaceWith(Bs4Element otherElement);

  void _wrap();

  void _unwrap();

  void _smooth();
}
