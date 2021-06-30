import 'package:html/dom.dart';

import 'bs4_element.dart';

extension ElementExt on Element {
  Bs4Element get bs4 => Bs4Element(this);
}
