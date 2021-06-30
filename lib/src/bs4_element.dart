// ignore_for_file: implementation_imports
import 'dart:collection';

import 'package:html/dom.dart';
import 'package:source_span/src/file.dart';

import 'extensions.dart';
import 'helpers.dart';
import 'impl/impl.dart';
import 'shared.dart';

class Bs4Element extends Shared
    implements ElementImpl, TreeNavigatorImpl, TreeModifierImpl {
  Bs4Element._(
    Element element,
  ) {
    this.element = element;
  }

  factory Bs4Element(Element element) => Bs4Element._(element);

  Element get _element => element!;

  @override
  String? get name => _element.localName;

  @override
  String get outerHtml => _element.outerHtml;

  @override
  String get string => _element.text;

  @override
  set string(String? value) => _element.text = value;

  @override
  String get strippedStrings {
    final strBuffer = StringBuffer();
    final strLines = _element.text.split('\n');
    for (final str in strLines) {
      final trimmed = str.trimLeft();
      if (trimmed != '') {
        if (strLines.length > 1) {
          strBuffer.write(trimmed + '\n');
        } else {
          strBuffer.write(trimmed);
        }
      }
    }
    return strBuffer.toString();
  }

  @override
  String get innerHtml => _element.innerHtml;

  @override
  set innerHtml(String value) => _element.innerHtml = value;

  @override
  String get className => _element.className;

  @override
  set className(String value) => _element.className = value;

  @override
  String get id => _element.id;

  @override
  set id(String value) => _element.id = value;

  @override
  List<Bs4Element> get children => _element.children.map((e) => e.bs4).toList();

  @override
  List<Bs4Element> get contents => children;

  @override
  List<Bs4Element> get descendants {
    return _element.children
        .map((e) => recursiveSearch(e.bs4))
        .expand((e) => e)
        .toList();
  }

  @override
  Bs4Element? get parent => _element.parent?.bs4;

  @override
  List<Bs4Element> get parents {
    final parents = <Bs4Element>[];
    Bs4Element? elementIter = parent;
    while (elementIter != null) {
      parents.add(elementIter);
      elementIter = elementIter.parent;
    }
    return parents;
  }

  @override
  Bs4Element? get previousSibling => _element.previousElementSibling?.bs4;

  @override
  List<Bs4Element> get previousSiblings {
    final previousSiblings = <Bs4Element>[];
    Bs4Element? elementIter = previousSibling;
    while (elementIter != null) {
      previousSiblings.add(elementIter);
      elementIter = elementIter.previousSibling;
    }
    return previousSiblings;
  }

  @override
  Bs4Element? get nextSibling => _element.nextElementSibling?.bs4;

  @override
  List<Bs4Element> get nextSiblings {
    final nextSiblings = <Bs4Element>[];
    Bs4Element? elementIter = nextSibling;
    while (elementIter != null) {
      nextSiblings.add(elementIter);
      elementIter = elementIter.nextSibling;
    }
    return nextSiblings;
  }

  @override
  void append(Bs4Element element) {
    _element.append(element._element);
  }

  @override
  void extend(List<Bs4Element> element) {
    for (final e in element) {
      _element.append(e._element);
    }
  }

  @override
  void insert(int position, Bs4Element element) =>
      _element.nodes.insert(position, element._element);

  @override
  void insertBefore(Bs4Element element, [Bs4Element? ref]) {
    if (ref == null) {
      insert(0, element);
    } else {
      _element.insertBefore(element._element, ref._element);
    }
  }

  @override
  void insertAfter(Bs4Element element, [Bs4Element? ref]) {
    if (ref == null) {
      _element.nodes.add(element._element);
    } else {
      final nodes = _element.nodes;
      final nl = nodes.length;
      final indexOf = nodes.indexOf(ref._element);
      if (indexOf < 0) {
        final msg = 'Referenced element does not exist in the parse tree.';
        throw (RangeError(msg));
      } else if ((nl - 1 == indexOf) ||
          (nl - 2 == indexOf && nodes[nl - 1].nodeType == 3)) {
        append(element);
      } else {
        _element.nodes.insert(indexOf + 1, element._element);
      }
    }
  }

  @override
  Bs4Element extract() => (_element.remove() as Element).bs4;

  @override
  Bs4Element replaceWith(Bs4Element otherElement) =>
      (_element.replaceWith(otherElement._element) as Element).bs4;

  // @override
  // Bs4Element? get nextElement {
  //   final parentNode = this.parentNode;
  //   if (parentNode == null) {
  //     return null;
  //   }
  //   final nodeSiblings = parentNode.nodes;
  //   for (var i = nodeSiblings.indexOf(_element) + 1; i < nodeSiblings.length; i++) {
  //     final element = nodeSiblings[i];
  //     return element;
  //   }
  //   return null;
  // }

  @override
  LinkedHashMap<Object, String> get attributes => _element.attributes;

  @override
  set attributes(LinkedHashMap<Object, String> _attributes) =>
      _element.attributes = _attributes;

  @override
  LinkedHashMap<Object, FileSpan>? get _attributeSpans =>
      _element.attributeSpans;

  @override
  LinkedHashMap<Object, FileSpan>? get _attributeValueSpans =>
      _element.attributeValueSpans;

  @override
  CssClassSet get _classes => _element.classes;

  @override
  FileSpan? get _endSourceSpan => _element.endSourceSpan;

  @override
  set _endSourceSpan(FileSpan? _endSourceSpan) =>
      _element.endSourceSpan = _endSourceSpan;

  @override
  Node? get _parentNode => _element.parentNode;

  @override
  set _parentNode(Node? _parentNode) => _element.parentNode = _parentNode;

  @override
  FileSpan? get _sourceSpan => _element.sourceSpan;

  @override
  set _sourceSpan(FileSpan? _sourceSpan) => _element.sourceSpan = _sourceSpan;

  @override
  String? get _namespaceUri => _element.namespaceUri;

  @override
  int get _nodeType => _element.nodeType;

  @override
  NodeList get nodes => _element.nodes;

  @override
  Node? get _firstChild => _element.firstChild;

  @override
  void _reparentChildren(Node newParent) =>
      _element.reparentChildren(newParent);

  @override
  Bs4Element _clone(bool deep) => (_element.clone(deep)).bs4;

  @override
  bool _hasContent() => _element.hasContent();

  @override
  bool _contains(Node node) => _element.contains(node);

  @override
  bool _hasChildNodes() => _element.hasChildNodes();

  @override
  String? operator [](String name) => _element.attributes[name];

  @override
  void operator []=(String name, String value) =>
      _element.attributes[name] = value;

  @override
  String toString() => outerHtml;
}
