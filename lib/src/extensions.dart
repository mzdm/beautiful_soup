import 'package:html/dom.dart';

import 'bs4_element.dart';

/// Extension for [Element].
extension ElementExt on Element {
  /// Returns [Bs4Element] from the [Element] ([which comes from
  /// `html` Dart package](https://pub.dev/packages/html)).
  Bs4Element get bs4 => Bs4Element(this);
}

/// Extensions for [Node].
extension NodeExt on Node {
  /// Gets the [String] (data) representation of this [Node].
  ///
  /// Usually outputs: doc comments, element tags, part of strings, ...
  String get data => _getDataFromNode(this);

  String _getDataFromNode(Node node) {
    switch (node.nodeType) {
      case Node.ELEMENT_NODE:
        return (node as Element).outerHtml;
      case Node.TEXT_NODE:
        return (node as Text).text;
      case Node.COMMENT_NODE:
        final data = (node as Comment).data;
        return '<!--$data-->';
      case Node.DOCUMENT_NODE:
        return (node as Document).outerHtml;
      case Node.DOCUMENT_TYPE_NODE:
        return (node as DocumentType).toString();
      case Node.DOCUMENT_FRAGMENT_NODE:
        return (node as DocumentFragment).outerHtml;
      case Node.ATTRIBUTE_NODE:
      case Node.CDATA_SECTION_NODE:
      case Node.ENTITY_REFERENCE_NODE:
      case Node.ENTITY_NODE:
      case Node.PROCESSING_INSTRUCTION_NODE:
      case Node.NOTATION_NODE:
        return node.toString();
      default:
        return node.toString();
    }
  }
}

extension ListExt<E> on List<E> {
  E? get firstOrNull => isEmpty ? null : first;
}

extension PatternExt on Pattern {
  RegExp get asRegExp => this is RegExp ? this as RegExp : RegExp(toString());
}
