// ignore_for_file: implementation_imports
import 'dart:collection';

import 'package:html/dom.dart';
import 'package:source_span/src/file.dart';

import '../bs4_element.dart';

abstract class ElementImpl {
  /// Returns the **tag name** (local name) of the element.
  ///
  /// Same as [element.localName].
  String? get name;

  /// Returns a fragment of HTML or XML that represents the element and its
  /// contents.
  ///
  /// Copied from [Element].
  String get outerHtml;

  /// Returns a fragment of HTML or XML that represents the element's contents.
  /// Can be set, to replace the contents of the element with nodes parsed from
  /// the given string.
  ///
  /// Copied from [Element].
  String get innerHtml;

  set innerHtml(String value);

  /// [DOM Element - className](http://dom.spec.whatwg.org/#dom-element-classname)
  String get className;

  set className(String value);

  /// [DOM Element - id](http://dom.spec.whatwg.org/#dom-element-id)
  String get id;

  set id(String value);

  LinkedHashMap<Object, String> get attributes;

  set attributes(LinkedHashMap<Object, String> _attributes);

  /// If [_sourceSpan] is available, this contains the spans of each attribute.
  /// The span of an attribute is the entire attribute, including the name and
  /// quotes (if any). For example, the span of "attr" in `<a attr="value">`
  /// would be the text `attr="value"`.
  ///
  /// Copied from [Element].
  LinkedHashMap<Object, FileSpan>? get _attributeSpans;

  /// If [_sourceSpan] is available, this contains the spans of each attribute's
  /// value. Unlike [_attributeSpans], this span will include only the value.
  /// For example, the value span of "attr" in `<a attr="value">` would be the
  /// text `value`.
  ///
  /// Copied from [Element].
  LinkedHashMap<Object, FileSpan>? get _attributeValueSpans;

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

  FileSpan? get _endSourceSpan;

  set _endSourceSpan(FileSpan? _endSourceSpan);

  Node? get _parentNode;

  set _parentNode(Node? _parentNode);

  FileSpan? get _sourceSpan;

  set _sourceSpan(FileSpan? _sourceSpan);

  String? get _namespaceUri;

  int get _nodeType;

  NodeList get nodes;

  Node? get _firstChild;

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

  bool _hasChildNodes();

  /// Gets an attribute value by [name].
  String? operator [](String name);

  /// Assigns a value to attribute by [name] and [value].
  operator []=(String name, String value);
}
