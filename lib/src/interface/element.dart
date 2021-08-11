import 'dart:collection';

import 'package:html/dom.dart';

import '../bs4_element.dart';

/// Most of the implementation comes from [`html` Dart package](https://pub.dev/packages/html).
abstract class IElement {
  /// Returns the **tag name** of the element.
  ///
  /// Same as [element.localName].
  String? get name;

  /// Returns a fragment of HTML or XML that represents the element and its
  /// contents.
  ///
  /// Copied from [Element].
  String get outerHtml;

  /// Returns a fragment of HTML or XML that represents the element's contents.
  ///
  /// Can be set, to replace the contents of the element with nodes parsed from
  /// the given string.
  ///
  /// Copied from [Element].
  String get innerHtml;

  set innerHtml(String value);

  /// Returns the value of the `class` attribute.
  ///
  /// Can be set.
  ///
  /// [DOM Element - className](http://dom.spec.whatwg.org/#dom-element-classname)
  String get className;

  set className(String value);

  /// Returns the value of the `id` attribute.
  ///
  /// Can be set.
  ///
  /// [DOM Element - id](http://dom.spec.whatwg.org/#dom-element-id)
  String get id;

  set id(String value);

  /// Returns a [LinkedHashMap] of the element's attributes.
  ///
  /// Where `key` is an attribute name and value is the `value` of an attribute.
  ///
  /// Can be set.
  LinkedHashMap<Object, String> get attributes;

  set attributes(LinkedHashMap<Object, String> _attributes);

  /// The set of CSS classes applied to this element.
  ///
  /// This set makes it easy to add, remove or toggle the classes applied to
  /// this element.
  ///
  ///     bs4.classes.add('selected');
  ///     bs4.classes.toggle('isOnline');
  ///     bs4.classes.remove('selected');
  ///
  /// Copied from [Element].
  CssClassSet get _classes;

  /// Returns the list of [Node]s.
  ///
  /// Can be used to iterate not only elements, but also doc comments. strings
  /// and etc.
  NodeList get nodes;

  /// Move all the children of the current node to [newParent].
  /// This is needed so that trees that don't store text as nodes move the
  /// text in the correct way.
  ///
  /// Copied from [Element].
  void _reparentChildren(Node newParent);

  /// Returns a copy of this node.
  ///
  /// If deep is `true`, then all of this node's children and descendants are
  /// copied as well. If deep is `false`, then only this node is copied.
  ///
  /// Copied from [Element].
  Bs4Element _clone(bool deep);

  /// Return true if the node has children or text.
  ///
  /// Copied from [Element].
  bool _hasContent();

  bool _contains(Node node);

  /// Gets an attribute value by [name].
  String? operator [](String name);

  /// Assigns a value to attribute by [name] and [value].
  operator []=(String name, String value);
}
