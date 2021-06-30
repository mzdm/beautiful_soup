import '../bs_soup.dart';

abstract class OutputImpl {
  /// The method will turn a [BeautifulSoup] parse tree into a nicely
  /// formatted Unicode string, with a separate line for each tag and
  /// each string.
  ///
  /// You can call [_prettify] on the top-level BeautifulSoup object, or on
  /// any of its element objects.
  ///
  /// Since it adds whitespace (in the form of newlines), [_prettify] changes
  /// the meaning of an HTML document and should not be used to reformat one.
  /// The goal of [_prettify] is to help you visually understand the structure
  /// of the documents you work with.
  void _prettify();

  /// Returns the text of an element.
  ///
  /// Same like `bs4element.string`.
  String getText();

  String get _unescape;

  String get _escape;

  String toString();
}
