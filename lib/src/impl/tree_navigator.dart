import '../bs4_element.dart';

abstract class TreeNavigatorImpl {
  /// The element's (tag's) children.
  List<Bs4Element> get children;

  /// The element's (tag's) children.
  ///
  /// Same as [element.children].
  List<Bs4Element> get contents;

  /// The element's (tag's) descendants.
  ///
  /// Similar to [children] but it iterates recursively.
  List<Bs4Element> get descendants;

  /// {@template bs4element_string}
  /// Returns or modifies the text of element(s).
  /// {@endtemplate}
  String get string;

  /// Returns the text of an element(s), trims extra whitespaces from the left
  /// and removes empty lines.
  String get strippedStrings;

  /// The element's parent.
  ///
  /// Returns null if this node either does not have a parent or its parent is
  /// not an element.
  Bs4Element? get parent;

  /// The element's all parents.
  ///
  /// Iterates from the element buried deep within the document,
  /// to the very top of the document.
  ///
  /// Returns null if this node either does not have a parent or its parent is
  /// not an element.
  List<Bs4Element> get parents;

  /// Gets previous element on the same level of the parse tree.
  Bs4Element? get previousSibling;

  /// Gets all previous elements on the same level of the parse tree.
  List<Bs4Element> get previousSiblings;

  /// Gets next element on the same level of the parse tree.
  Bs4Element? get nextSibling;

  /// Gets all next elements on the same level of the parse tree.
  List<Bs4Element> get nextSiblings;

  Bs4Element? get _nextElement;

  List<Bs4Element> get _nextElements;

  Bs4Element? get _previousElement;

  List<Bs4Element> get _previousElements;
}
