import 'package:html/dom.dart';

import '../bs4_element.dart';

/// Contains methods from [Modifying the tree](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#modifying-the-tree).
// TODO: smooth
abstract class ITreeModifier {
  /// {@macro bs4element_string}
  set string(String? value);

  /// {@macro bs4element_name}
  set name(String? value);

  /// Adds an element just before the closing tags of the current element.
  ///
  /// If you want to pass [Node] instead [Bs4Element], you can do it via
  /// `bs4element.element.append(node)`.
  void append(Bs4Element element);

  /// Adds elements just before the closing tags of the current element,
  /// in order.
  void extend(List<Bs4Element> element);

  /// {@template tree_modifier_newTag}
  /// Creates a new [Bs4Element].
  ///
  /// * [name] - tag name
  /// * [attrs] - attributes to be added to the tag
  /// * [string] - text content
  /// {@endtemplate}
  Bs4Element newTag(String? name, {Map<String, String>? attrs, String? string});

  /// It is just like [append], except the new element does not necessarily
  /// go at the end of its parent’s .[contents]. It’ll be inserted at
  /// whatever numeric position you say, just after the opening tag of the
  /// current element.
  ///
  /// If the position is out of range, throws [RangeError].
  ///
  ///
  /// If you want to pass [Node] instead [Bs4Element], you can do it via
  /// `bs4element.element.insert(index, node)`.
  void insert(int position, Bs4Element element);

  /// Inserts an element immediately before the current element in
  /// the parse tree.
  ///
  /// [ref] specifies an position of an element, where should the insertion
  /// apply.
  ///
  /// If the [ref] is not in the parse tree, throws [RangeError].
  ///
  /// If you want to pass [Node] instead [Bs4Element], you can do it via
  /// `bs4element.element.insertBefore(node, nodeRef)`.
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

  /// Removes the contents of a tag.
  void clear();

  /// Removes an element from the tree.
  ///
  /// Returns the element that was extracted.
  Bs4Element extract();

  /// Removes a tag from the tree, then completely destroys it and its contents.
  void decompose();

  /// Removes an element from the tree, and replaces it with [otherElement].
  ///
  /// Returns the element that was replaced.
  ///
  ///
  /// If you want to pass [Node] instead [Bs4Element], you can do it via
  /// `bs4element.element.replaceWith(node)`.
  Bs4Element replaceWith(Bs4Element otherElement);

  /// Wraps an element in the tag you specify. It returns the new wrapper.
  // TODO: possibility to wrap also string?
  Bs4Element wrap(Bs4Element newParentElement);

  /// [unwrap] is the opposite of [wrap].
  ///
  /// It replaces a tag with whatever’s inside that tag.
  ///
  /// It’s good for stripping out markup.
  ///
  /// Like [replaceWith], `unwrap` returns the tag that was replaced.
  Bs4Element? unwrap();

  /// Cleans up the parse tree by consolidating adjacent strings.
  // ignore: unused_element
  void _smooth();

  /// {@template tree_modifier_setAttr}
  /// Sets the [value] of an attribute on the specified element.
  ///
  /// If the attribute already exists, the value is updated;
  /// otherwise a new attribute is added with the specified [name] and [value].
  /// {@endtemplate}
  operator []=(String name, String value);

  /// {@macro tree_modifier_setAttr}
  void setAttr(String name, String value);

  /// Removes the attribute with the specified [name] from the element.
  void removeAttr(String name);
}
