import '../bs4_element.dart';

/// Contains methods from [Navigating the tree](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#navigating-the-tree).
abstract class TreeNavigatorImpl {
  /// {@template tree_navigator_children}
  /// The element's (tag's) children.
  /// {@endtemplate}
  List<Bs4Element> get children;

  /// {@macro tree_navigator_children}
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
  List<Bs4Element> get parents;

  /// Gets previous element on the same level of the parse tree.
  Bs4Element? get previousSibling;

  /// Gets all previous elements on the same level of the parse tree.
  List<Bs4Element> get previousSiblings;

  /// Gets next element on the same level of the parse tree.
  Bs4Element? get nextSibling;

  /// Gets all next elements on the same level of the parse tree.
  List<Bs4Element> get nextSiblings;

  /// {@template tree_navigator_nextElement}
  /// The [nextElement] is a string or tag that was parsed
  /// immediately afterwards.
  ///
  /// It might be the same as [nextSibling], except it returns String and not
  /// [Bs4Element] and it’s usually drastically different.
  /// {@endtemplate}
  Bs4Element? get _nextElement;

  /// {@macro tree_navigator_nextElement}
  ///
  /// Returns a list of [_nextElement]s.
  List<String> get _nextElements;

  /// {@template tree_navigator_previousElement}
  /// The [previousElement] is a string or tag that was parsed
  /// immediately before the current element.
  ///
  /// It might be the same as [previousSibling], except it returns String
  /// and not [Bs4Element] and it’s usually drastically different.
  /// {@endtemplate}
  Bs4Element? get _previousElement;

  /// {@macro tree_navigator_previousElement}
  ///
  /// Returns a list of [_previousElement]s.
  List<Bs4Element> get _previousElements;
}
