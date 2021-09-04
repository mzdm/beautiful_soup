import 'package:html/dom.dart';

import 'bs4_element.dart';
import 'bs_soup.dart';
import 'extensions.dart';
import 'interface/interface.dart';

class Tags implements ITags {
  Element? element;
  Document? _doc;
  DocumentFragment? _docFragment;

  /// Returns [Document] or [DocumentFragment], based on what parser was used
  /// with the [BeautifulSoup] constructor.
  ///
  /// This should not be used publicly along with setter.
  ///
  /// Can return null.
  dynamic get doc => _doc ?? _docFragment;

  set doc(dynamic value) {
    if (value is Document) {
      _doc = value;
      _docFragment = null;
    } else {
      _docFragment = value;
      _doc = null;
    }
  }

  Bs4Element? _findFirst(String tagName) =>
      ((element ?? doc).querySelector(tagName) as Element?)?.bs4;

  @override
  Bs4Element? get html => _findFirst('html');

  @override
  Bs4Element? get body => _findFirst('body');

  @override
  Bs4Element? get head => _findFirst('head');

  @override
  Bs4Element? get a => _findFirst('a');

  @override
  Bs4Element? get b => _findFirst('b');

  @override
  Bs4Element? get i => _findFirst('i');

  @override
  Bs4Element? get p => _findFirst('p');

  @override
  Bs4Element? get title => _findFirst('title');

  @override
  Bs4Element? get h1 => _findFirst('h1');

  @override
  Bs4Element? get h2 => _findFirst('h2');

  @override
  Bs4Element? get h3 => _findFirst('h3');

  @override
  Bs4Element? get h4 => _findFirst('h4');

  @override
  Bs4Element? get h5 => _findFirst('h5');

  @override
  Bs4Element? get h6 => _findFirst('h6');

  @override
  Bs4Element? get img => _findFirst('img');

  @override
  Bs4Element? get table => _findFirst('table');

  @override
  Bs4Element? get dl => _findFirst('dl');

  @override
  Bs4Element? get ul => _findFirst('ul');

  @override
  Bs4Element? get ol => _findFirst('ol');
}
