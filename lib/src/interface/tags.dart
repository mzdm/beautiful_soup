import '../bs4_element.dart';

/// Contains some most common tags for quick and easy navigating
/// down the parse tree.
abstract class ITags {
  /// {@template tags_common_tag}
  /// Returns the first occurrence of this tag down the parse tree.
  /// {@endtemplate}
  Bs4Element? get html;

  /// {@macro tags_common_tag}
  Bs4Element? get head;

  /// {@macro tags_common_tag}
  Bs4Element? get body;

  /// {@macro tags_common_tag}
  Bs4Element? get title;

  /// {@macro tags_common_tag}
  Bs4Element? get h1;

  /// {@macro tags_common_tag}
  Bs4Element? get h2;

  /// {@macro tags_common_tag}
  Bs4Element? get h3;

  /// {@macro tags_common_tag}
  Bs4Element? get h4;

  /// {@macro tags_common_tag}
  Bs4Element? get h5;

  /// {@macro tags_common_tag}
  Bs4Element? get h6;

  /// {@macro tags_common_tag}
  Bs4Element? get p;

  /// {@macro tags_common_tag}
  Bs4Element? get a;

  /// {@macro tags_common_tag}
  Bs4Element? get b;

  /// {@macro tags_common_tag}
  Bs4Element? get i;

  /// {@macro tags_common_tag}
  Bs4Element? get img;

  /// {@macro tags_common_tag}
  Bs4Element? get table;

  /// {@macro tags_common_tag}
  Bs4Element? get ul;

  /// {@macro tags_common_tag}
  Bs4Element? get ol;

  /// {@macro tags_common_tag}
  Bs4Element? get dl;
}
