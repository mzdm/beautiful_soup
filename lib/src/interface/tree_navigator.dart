import 'package:html/dom.dart';

import '../bs4_element.dart';

/// Contains methods from [Navigating the tree](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#navigating-the-tree).
abstract class ITreeNavigator {
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
  /// The [nextElement] is an element that was parsed immediately afterwards
  /// (firstly searches next elements of [children], if empty then
  /// [nextSiblings]).
  ///
  /// Use [nextParsed] if you want to get any type
  /// (doc comment, part of string, ...).
  /// {@endtemplate}
  Bs4Element? get nextElement;

  /// {@macro tree_navigator_nextElement}
  ///
  /// Returns a list of [nextElement]s.
  List<Bs4Element> get nextElements;

  /// {@template tree_navigator_previousElement}
  /// The [previousElement] is an element that was parsed
  /// immediately before the current element
  /// (firstly searches [previousSiblings], if empty then [parent]).
  ///
  /// Use [previousParsed] if you want to get any type
  /// (doc comment, part of string, ...).
  /// {@endtemplate}
  Bs4Element? get previousElement;

  /// {@macro tree_navigator_previousElement}
  ///
  /// Returns a list of [previousElement]s.
  List<Bs4Element> get previousElements;

  /// {@template tree_navigator_nextParsed}
  /// Similar to [nextElement] but it returns a [Node] of what was parsed
  /// immediately after the current element. It might be doc comment, element,
  /// part of string, etc...
  ///
  /// To get the [String] (data) representation of this [Node], use
  /// `node.data`.
  /// {@endtemplate}
  Node? get nextParsed;

  /// {@macro tree_navigator_nextParsed}
  ///
  /// Returns a list of [nextParsed]s.
  List<Node> get nextParsedAll;

  /// {@template tree_navigator_previousParsed}
  /// Similar to [previousElement] but it returns a [Node] of what was parsed
  /// immediately before the current element. It might be doc comment, element,
  /// part of string, etc...
  ///
  /// To get the [String] (data) representation of this [Node], use
  /// `node.data`.
  /// {@endtemplate}
  Node? get previousParsed;

  /// {@macro tree_navigator_previousParsed}
  ///
  /// Returns a list of [previousParsed]s.
  List<Node> get previousParsedAll;
}
