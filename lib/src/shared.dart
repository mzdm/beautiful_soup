import 'package:html/dom.dart';

import 'bs4_element.dart';
import 'extensions.dart';
import 'impl/impl.dart';
import 'tags.dart';

class Shared extends Tags implements TreeSearcherImpl, OutputImpl {
  @override
  List<Bs4Element> findAll(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
  }) {
    if (customSelector != null) {
      return ((element ?? doc).querySelectorAll(customSelector)
              as List<Element>)
          .map((e) => e.bs4)
          .toList();
    }
    bool anyTag = name == '*';
    if (attrs == null && !anyTag) {
      return ((element ?? doc).querySelectorAll(name) as List<Element>)
          .map((e) => e.bs4)
          .toList();
    }
    final selector = (anyTag && attrs == null)
        ? '*'
        : _selectorBuilder(tagName: name, attrs: attrs!);
    final elements =
        ((element ?? doc).querySelectorAll(selector) as List<Element>)
            .map((e) => e.bs4);
    return elements.toList();
  }

  @override
  Bs4Element? findFirstAny() =>
      ((element ?? doc).querySelector('html') as Element?)?.bs4 ??
      ((element ?? doc).querySelector('*') as Element?)?.bs4;

  @override
  Bs4Element? find(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
  }) {
    if (customSelector != null) {
      return ((element ?? doc).querySelector(customSelector) as Element?)?.bs4;
    }
    bool anyTag = name == '*';
    if (attrs == null && !anyTag) {
      return ((element ?? doc).querySelector(name) as Element?)?.bs4;
    }
    final selector = (anyTag && attrs == null)
        ? '*'
        : _selectorBuilder(tagName: name, attrs: attrs!);
    return ((element ?? doc).querySelector(selector) as Element?)?.bs4;
  }

  @override
  void _prettify() {
    throw UnimplementedError();
    // final element = findFirstAny();
    // if (element == null) {
    //   return;
    // }
    // print(element.descendants.join('---- \n'));
    // final descendants = element.children
    //     .map((e) {
    //       return recursiveSearch(e);
    //     })
    //     .expand((e) => e)
    //     .toList();
  }

  @override
  String getText() => element?.text ?? findFirstAny()?.getText() ?? '';
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
