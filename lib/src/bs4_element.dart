import 'dart:collection';

import 'package:html/dom.dart';

import 'extensions.dart';
import 'helpers.dart';
import 'interface/interface.dart';
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
  Bs4Element? get nextElement {
    // find within children
    final children = this.children;
    if (children.isNotEmpty) {
      return children.first;
    }

    // find within next sibling
    final nextSibling = this.nextSibling;
    if (nextSibling != null) {
      return nextSibling;
    }

    // find within parent and next siblings
    var parent = this.parent;
    while (parent != null) {
      if (parent.nextSibling == null) {
        parent = parent.parent;
      } else {
        return parent.nextSibling;
      }
    }

    return null;
  }

  @override
  List<Bs4Element> get nextElements {
    final nextElements = <Bs4Element>[];

    // find within children
    nextElements.addAll(descendants);

    // find within next siblings
    nextElements.addAll(nextSiblings);

    // find within parent and next siblings
    var parent = this.parent;
    while (parent != null) {
      nextElements.addAll(parent.nextSiblings);
      parent = parent.parent;
    }

    return nextElements;
  }

  @override
  Bs4Element? get previousElement {
    // find within prev sibling
    final prevSibling = previousSibling;
    if (prevSibling != null) {
      return prevSibling;
    }

    // find within parent, or null
    return parent;
  }

  @override
  List<Bs4Element> get previousElements {
    final prevElements = <Bs4Element>[];

    // find within prev siblings
    prevElements.addAll(previousSiblings);

    // find within parent and prev siblings
    var parent = this.parent;
    while (parent != null) {
      prevElements
        ..add(parent)
        ..addAll(parent.previousSiblings);

      parent = parent.parent;
    }

    return prevElements;
  }

  @override
  Node? get nextParsed {
    final element = this.element;
    if (element == null) return null;

    // find within children
    if (element.hasChildNodes()) {
      return element.nodes.first;
    }

    final parentNode = element.parentNode;
    if (parentNode == null) return null;

    // find within next siblings
    final nextIndex = _getCurrNodeIndex(parentNode, element) + 1;
    final allSiblings = parentNode.nodes;
    if (nextIndex < allSiblings.length) {
      return allSiblings[nextIndex];
    }

    // find within parent and next siblings
    Node prevNode = parentNode;
    Node? parent = parentNode.parentNode;
    while (parent != null) {
      final nextIndex = _getCurrNodeIndex(parent, prevNode) + 1;
      final allSiblings = parent.nodes;

      if (nextIndex < allSiblings.length) {
        return allSiblings[nextIndex];
      }

      prevNode = parent;
      parent = parent.parentNode;
    }

    return null;
  }

  @override
  List<Node> get nextParsedAll {
    // TODO: iterate also in siblings though descendants?
    final nextParsedAll = <Node>[];

    final element = this.element;
    if (element == null) return nextParsedAll;

    // find within children
    if (element.hasChildNodes()) {
      final descendants = element.nodes
          .map((node) => recursiveNodeSearch(node))
          .expand((e) => e)
          .toList();
      nextParsedAll.addAll(descendants);
    }

    final parentNode = element.parentNode;
    if (parentNode == null) return nextParsedAll;

    // find within next siblings
    final nextIndex = _getCurrNodeIndex(parentNode, element) + 1;
    final allSiblings = parentNode.nodes;
    if (nextIndex < allSiblings.length) {
      final rangeList = allSiblings.getRange(nextIndex, allSiblings.length);
      nextParsedAll.addAll(rangeList);
    }

    // find within parent and next siblings
    Node prevNode = parentNode;
    Node? parent = parentNode.parentNode;
    while (parent != null) {
      final nextIndex = _getCurrNodeIndex(parent, prevNode) + 1;
      final allSiblings = parent.nodes;

      if (nextIndex < allSiblings.length) {
        final rangeList = allSiblings.getRange(nextIndex, allSiblings.length);
        nextParsedAll.addAll(rangeList);
      }

      prevNode = parent;
      parent = parent.parentNode;
    }

    return nextParsedAll;
  }

  @override
  Node? get previousParsed {
    final element = this.element;
    if (element == null) return null;

    final parentNode = element.parentNode;
    if (parentNode == null) return null;

    // find within prev siblings
    final prevIndex = _getCurrNodeIndex(parentNode, element) - 1;
    final allSiblings = parentNode.nodes;
    if (prevIndex >= 0) {
      return allSiblings[prevIndex];
    }

    // find within parent or null
    return parentNode.parentNode;
  }

  @override
  List<Node> get previousParsedAll {
    final prevParsedAll = <Node>[];

    final element = this.element;
    if (element == null) return prevParsedAll;

    final parentNode = element.parentNode;
    if (parentNode == null) return prevParsedAll;

    // find within parent and prev siblings
    final prevIndex = _getCurrNodeIndex(parentNode, element) - 1;
    final allSiblings = parentNode.nodes;
    if (prevIndex >= 0) {
      final rangeList = allSiblings.getRange(0, prevIndex + 1);
      prevParsedAll.addAll(List.of(rangeList).reversed);
    }

    Node prevNode = parentNode;
    Node? parent = parentNode.parentNode;
    while (parent != null) {
      final prevIndex = _getCurrNodeIndex(parent, prevNode) - 1;
      final allSiblings = parent.nodes;

      if (prevIndex == -1) {
        // top most element (?)
        prevParsedAll.add(allSiblings.first);
      } else if (prevIndex >= 0) {
        final rangeList = allSiblings.getRange(0, prevIndex + 1);
        prevParsedAll.addAll(List.of(rangeList).reversed);
      }

      prevNode = parent;
      parent = parent.parentNode;
    }

    return prevParsedAll;
  }

  @override
  void append(Bs4Element element) => _element.append(element._element);

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

  @override
  LinkedHashMap<Object, String> get attributes => _element.attributes;

  @override
  set attributes(LinkedHashMap<Object, String> _attributes) =>
      _element.attributes = _attributes;

  @override
  CssClassSet get _classes => _element.classes;

  @override
  NodeList get nodes => _element.nodes;

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
  String? operator [](String name) => _element.attributes[name];

  @override
  void operator []=(String name, String value) =>
      _element.attributes[name] = value;

  @override
  String toString() => outerHtml;
}

int _getCurrNodeIndex(Node parentNode, Node currentNode) {
  final allSiblings = parentNode.nodes;
  final nextIndex = allSiblings.indexOf(currentNode);
  return nextIndex;
}
