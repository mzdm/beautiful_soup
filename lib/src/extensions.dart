import 'package:html/dom.dart';

import 'bs4_element.dart';

extension ElementExt on Element {
  /// Returns [Bs4Element] from the [Element] ([which comes from
  /// `html` Dart package](https://pub.dev/packages/html)).
  Bs4Element get bs4 => Bs4Element(this);
}
