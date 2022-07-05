// ignore_for_file: non_constant_identifier_names

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:html/dom.dart';

import 'interface/interface.dart';
import 'tags.dart';

class Shared extends Tags implements ITreeSearcher, IOutput {
  @override
  Bs4Element? findFirstAny() =>
      ((element ?? doc).querySelector('html') as Element?)?.bs4 ??
      ((element ?? doc).querySelector('*') as Element?)?.bs4;

  @override
  Bs4Element? find(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  }) {
    if (selector != null) {
      return ((element ?? doc).querySelector(selector) as Element?)?.bs4;
    }
    if (id == null && class_ == null && regex == null && string == null) {
      bool anyTag = _isAnyTag(name);
      bool validTag = _isValidTag(name);
      if (attrs == null && !anyTag && validTag) {
        return ((element ?? doc).querySelector(name) as Element?)?.bs4;
      }
      final cssSelector = ((!validTag || anyTag) && (attrs == null))
          ? '*'
          : _selectorBuilder(tagName: validTag ? name : '*', attrs: attrs!);
      return ((element ?? doc).querySelector(cssSelector) as Element?)?.bs4;
    }
    return findAll(
      name,
      id: id,
      class_: class_,
      attrs: attrs,
      regex: regex,
      string: string,
      selector: selector,
    ).firstOrNull;
  }

  @override
  List<Bs4Element> findAll(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  }) {
    assert(limit == null || limit >= 0);

    if (selector != null) {
      return ((element ?? doc).querySelectorAll(selector) as List<Element>)
          .map((e) => e.bs4)
          .toList();
    }
    bool anyTag = _isAnyTag(name);
    bool validTag = _isValidTag(name);
    if (attrs == null && !anyTag && validTag) {
      final elements =
          ((element ?? doc).querySelectorAll(name) as List<Element>)
              .map((e) => e.bs4)
              .toList();
      final filtered = _filterResults(
        allResults: elements.toList(),
        id: id,
        class_: class_,
        regex: regex,
        string: string,
      );
      return _limitedList(filtered, limit);
    }
    final cssSelector = ((!validTag || anyTag) && (attrs == null))
        ? '*'
        : _selectorBuilder(tagName: validTag ? name : '*', attrs: attrs!);
    final elements =
        ((element ?? doc).querySelectorAll(cssSelector) as List<Element>)
            .map((e) => e.bs4);

    final filtered = _filterResults(
      allResults: elements.toList(),
      id: id,
      class_: class_,
      regex: regex,
      string: string,
    );
    return _limitedList(filtered, limit);
  }

  @override
  Bs4Element? findParent(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  }) {
    final filtered = findParents(name, attrs: attrs, selector: selector);
    return filtered.firstOrNull;
  }

  @override
  List<Bs4Element> findParents(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  }) {
    assert(limit == null || limit >= 0);
    final matched = <Bs4Element>[];

    final bs4 = _bs4;
    final bs4Parents = bs4.parents;
    if (bs4Parents.isEmpty) return matched;

    final topElement = _getTopElement(bs4);
    final allResults = _getAllResults(
      topElement: topElement,
      name: name,
      class_: class_,
      id: id,
      attrs: attrs,
      regex: regex,
      string: string,
      selector: selector,
    );

    final filtered = _findMatches(allResults, bs4Parents);
    matched.addAll(List.of(filtered).reversed);

    return _limitedList(matched, limit);
  }

  @override
  Bs4Element? findNextSibling(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  }) {
    final filtered = findNextSiblings(name, attrs: attrs, selector: selector);
    return filtered.firstOrNull;
  }

  @override
  List<Bs4Element> findNextSiblings(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  }) {
    assert(limit == null || limit >= 0);

    final matched = <Bs4Element>[];
    final bs4 = _bs4;
    final bs4NextSiblings = bs4.nextSiblings;
    if (bs4NextSiblings.isEmpty) return matched;

    final topElement = _getTopElement(bs4);
    final allResults = _getAllResults(
      topElement: topElement,
      name: name,
      class_: class_,
      id: id,
      attrs: attrs,
      regex: regex,
      string: string,
      selector: selector,
    );

    final filtered = _findMatches(allResults, bs4NextSiblings);
    matched.addAll(filtered);

    return _limitedList(matched, limit);
  }

  @override
  Bs4Element? findPreviousSibling(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  }) {
    final filtered = findPreviousSiblings(
      name,
      attrs: attrs,
      selector: selector,
    );
    return filtered.firstOrNull;
  }

  @override
  List<Bs4Element> findPreviousSiblings(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  }) {
    assert(limit == null || limit >= 0);

    final matched = <Bs4Element>[];
    final bs4 = _bs4;
    final bs4PrevSiblings = bs4.previousSiblings;
    if (bs4PrevSiblings.isEmpty) return matched;

    final topElement = _getTopElement(bs4);
    final allResults = _getAllResults(
      topElement: topElement,
      name: name,
      class_: class_,
      id: id,
      attrs: attrs,
      regex: regex,
      string: string,
      selector: selector,
    );

    final filtered = _findMatches(allResults, bs4PrevSiblings);
    matched.addAll(List.of(filtered).reversed);

    return _limitedList(matched, limit);
  }

  @override
  Bs4Element? findNextElement(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  }) {
    final filtered =
        findAllNextElements(name, attrs: attrs, selector: selector);
    return filtered.firstOrNull;
  }

  @override
  List<Bs4Element> findAllNextElements(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  }) {
    assert(limit == null || limit >= 0);

    final matched = <Bs4Element>[];
    final bs4 = _bs4;
    final bs4NextElements = bs4.nextElements;
    if (bs4NextElements.isEmpty) return matched;

    final topElement = _getTopElement(bs4);
    final allResults = _getAllResults(
      topElement: topElement,
      name: name,
      class_: class_,
      id: id,
      attrs: attrs,
      regex: regex,
      string: string,
      selector: selector,
    );

    final filtered = _findMatches(allResults, bs4NextElements);
    matched.addAll(filtered);

    return _limitedList(matched, limit);
  }

  @override
  Bs4Element? findPreviousElement(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  }) {
    final filtered = findAllPreviousElements(
      name,
      attrs: attrs,
      selector: selector,
    );
    return filtered.firstOrNull;
  }

  @override
  List<Bs4Element> findAllPreviousElements(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  }) {
    assert(limit == null || limit >= 0);

    final matched = <Bs4Element>[];
    final bs4 = _bs4;
    final bs4PrevElements = bs4.previousElements;
    if (bs4PrevElements.isEmpty) return matched;

    final topElement = _getTopElement(bs4);
    final allResults = _getAllResults(
      topElement: topElement,
      name: name,
      class_: class_,
      id: id,
      attrs: attrs,
      regex: regex,
      string: string,
      selector: selector,
    );

    final filtered = _findMatches(allResults, bs4PrevElements);
    matched.addAll(List.of(filtered).reversed);

    return _limitedList(matched, limit);
  }

  @override
  Node? findNextParsed({
    RegExp? pattern,
    int? nodeType,
  }) {
    final filtered = findNextParsedAll(pattern: pattern, nodeType: nodeType);
    return filtered.firstOrNull;
  }

  @override
  List<Node> findNextParsedAll({
    RegExp? pattern,
    int? nodeType,
    int? limit,
  }) {
    assert(limit == null || limit >= 0);

    final bs4 = _bs4;
    final bs4NextParsedAll = bs4.nextParsedAll;
    if (bs4NextParsedAll.isEmpty) return <Node>[];
    if (pattern == null && nodeType == null) {
      return _limitedList(bs4NextParsedAll, limit);
    }

    final filtered = bs4NextParsedAll.where((node) {
      if (pattern != null && nodeType == null) {
        return pattern.hasMatch(node.data);
      } else if (pattern == null && nodeType != null) {
        return nodeType == node.nodeType;
      } else {
        return (nodeType == node.nodeType) && (pattern!.hasMatch(node.data));
      }
    });

    return _limitedList(filtered.toList(), limit);
  }

  @override
  Node? findPreviousParsed({
    RegExp? pattern,
    int? nodeType,
  }) {
    final filtered =
        findPreviousParsedAll(pattern: pattern, nodeType: nodeType);
    return filtered.firstOrNull;
  }

  @override
  List<Node> findPreviousParsedAll({
    RegExp? pattern,
    int? nodeType,
    int? limit,
  }) {
    assert(limit == null || limit >= 0);

    final bs4 = _bs4;
    final bs4PrevParsedAll = bs4.previousParsedAll;
    if (bs4PrevParsedAll.isEmpty) return <Node>[];
    if (pattern == null && nodeType == null) {
      return _limitedList(bs4PrevParsedAll, limit);
    }

    final filtered = bs4PrevParsedAll.where((node) {
      if (pattern != null && nodeType == null) {
        return pattern.hasMatch(node.data);
      } else if (pattern == null && nodeType != null) {
        return nodeType == node.nodeType;
      } else {
        return (nodeType == node.nodeType) && (pattern!.hasMatch(node.data));
      }
    });

    return _limitedList(filtered.toList(), limit);
  }

  @override
  String getText({String separator = '', bool strip = false}) {
    if (separator.isEmpty && !strip) {
      return element?.text ?? _bs4.text;
    }

    final texts = _bs4.nextParsedAll
        .where((node) => node.nodeType == Node.TEXT_NODE)
        .map((textNode) => strip ? textNode.data.trim() : textNode.data)
        .toList()
      ..removeWhere((e) => e.isEmpty);

    return texts.join(separator);
  }

  @override
  String get text => getText();

  @override
  String prettify() {
    final topElement = findFirstAny()?.clone(true);
    if (topElement == null ||
        topElement.element == null ||
        topElement.nextParsed == null) {
      return _bs4.outerHtml;
    }

    final strBuffer = StringBuffer();
    void indent(int? indentation) {
      for (int i = 0; i < (indentation ?? 1); i++) {
        strBuffer.write(' ');
      }
    }

    final topElementData = _TagDataExtractor.parseElement(topElement.element!);
    final topClosingTag = topElementData.closingTag;
    strBuffer
      ..write(topElementData.startingTag)
      ..write('\n');

    final lists = <_TagDataExtractor>[];
    if (topElement.element!.hasChildNodes()) {
      final children = topElement.element!.nodes;

      var spaces = 1;
      for (final child in children) {
        spaces = 1;
        final current = _TagDataExtractor.parseNode(child, indentation: spaces);
        lists.add(current);

        final descendants = child.nodes
            .map((node) {
              spaces++;
              return _recursiveNodeExtractorSearch(node, indentation: spaces);
            })
            .expand((e) => e)
            .toList();
        lists.addAll(descendants);
      }
    }

    _TagDataExtractor? prevNode;
    for (final item in lists) {
      indent(item.indentation);
      strBuffer
        ..write(item.isElement ? item.startingTag : item.node.data)
        ..write('\n');

      if (prevNode != null && prevNode.isElement && prevNode != item) {
        indent(prevNode.indentation);
        strBuffer
          ..write(prevNode.closingTag)
          ..write('\n');
      }

      prevNode = item;
    }

    strBuffer.write(topClosingTag);
    return strBuffer.toString();
  }

  Bs4Element get _bs4 => element != null ? element!.bs4 : findFirstAny()!;
}

String _selectorBuilder({
  required String tagName,
  required Map<String, Object> attrs,
}) {
  final strBuffer = StringBuffer()..write(tagName);
  for (var entry in attrs.entries) {
    final attrName = entry.key;
    final attrValue = entry.value;
    assert(
      attrValue is bool || attrValue is String,
      'The allowed type of value of an attribute is '
      'either String or bool but was: ${attrValue.runtimeType}',
    );
    final attrHasValue = !(attrValue is bool && attrValue == true);
    if (attrHasValue) {
      // if the value space then search for exact attribute, otherwise search
      // any, https://drafts.csswg.org/selectors-4/#attribute-representation
      final searchMode = attrValue.toString().contains(' ') ? ' ' : '~';
      strBuffer.write('[$attrName$searchMode="$attrValue"]');
    } else {
      strBuffer.write('[$attrName]');
    }
  }
  return strBuffer.toString();
}

Bs4Element _getTopElement(Bs4Element bs4) {
  final parents = bs4.parents;
  return parents.isEmpty ? bs4 : parents.last;
}

List<Bs4Element> _filterResults({
  required List<Bs4Element> allResults,
  required String? id,
  required String? class_,
  required Pattern? regex,
  required Pattern? string,
}) {
  if (id == null && class_ == null && regex == null && string == null) {
    return allResults;
  }

  var filtered = List.of(allResults);
  if (class_ != null) {
    filtered =
        List.of(filtered).where((e) => e.className.contains(class_)).toList();
  }
  if (id != null) {
    filtered = List.of(filtered).where((e) => e.id == id).toList();
  }
  if (regex != null) {
    final regExp = regex.asRegExp;
    filtered = List.of(filtered).where((e) {
      if (regExp.hasMatch(e.name ?? '')) return true;
      return false;
    }).toList();
  }
  if (string != null) {
    final regExp = string.asRegExp;
    filtered = List.of(filtered).where((e) {
      if (regExp.hasMatch(e.string)) return true;
      return false;
    }).toList();
  }
  return filtered;
}

bool _isAnyTag(String name) => name == '*';

bool _isValidTag(String name) => name != '';

List<Bs4Element> _getAllResults({
  required Bs4Element topElement,
  required String name,
  required String? id,
  required String? class_,
  required Map<String, Object>? attrs,
  required Pattern? regex,
  required Pattern? string,
  required String? selector,
}) {
  final allResults = topElement.findAll(
    name,
    attrs: attrs,
    regex: regex,
    string: string,
    selector: selector,
  );

  // findAll does not return top most element, thus must be checked if
  // it matches as well
  if (attrs == null &&
      selector == null &&
      id == null &&
      class_ == null &&
      string == null &&
      regex == null) {
    if (name == '*' || name == topElement.name) {
      allResults.insert(0, topElement);
    }
  }

  return allResults;
}

Iterable<Bs4Element> _findMatches(
  List<Bs4Element> allResults,
  List<Bs4Element> filteredResults,
) {
  return allResults.where((anyResult) {
    return filteredResults.any((parent) {
      return parent.element == anyResult.element;
    });
  });
}

List<E> _limitedList<E>(List<E> list, int? limit) {
  return limit == null ? list : list.take(limit).toList();
}

class _TagDataExtractor {
  const _TagDataExtractor._({
    required this.node,
    this.startingTag = '',
    this.closingTag = '',
    this.indentation = 1,
  });

  final Node node;
  final String startingTag;
  final String closingTag;
  final int indentation;

  bool get isElement => node is Element;

  factory _TagDataExtractor.parseNode(Node node, {int? indentation}) {
    return node is Element
        ? _TagDataExtractor.parseElement(node, indentation: indentation)
        : _TagDataExtractor._(node: node, indentation: indentation ?? 1);
  }

  factory _TagDataExtractor.parseElement(Element element, {int? indentation}) {
    final topElement = element.clone(false);
    final closingTag = '</${topElement.localName}>';
    final startingTag = topElement.outerHtml.replaceFirst(closingTag, '');
    return _TagDataExtractor._(
      node: element,
      startingTag: startingTag,
      closingTag: closingTag,
      indentation: indentation ?? 1,
    );
  }

  @override
  String toString() =>
      '_TagDataExtractor{node: $node, startingTag: $startingTag, closingTag: $closingTag, indentation: $indentation}';
}

Iterable<_TagDataExtractor> _recursiveNodeExtractorSearch(
  Node node, {
  int? indentation,
}) sync* {
  yield _TagDataExtractor.parseNode(node, indentation: indentation ?? 1);
  for (final e in node.nodes) {
    yield* _recursiveNodeExtractorSearch(e, indentation: indentation ?? 1);
  }
}
