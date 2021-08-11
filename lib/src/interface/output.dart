import '../bs_soup.dart';

/// Contains methods from [Output](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#output).
/// TODO: prettify, encode/decode?, getText params: separator(String) and strip(bool)
abstract class IOutput {
  /// The method will turn a [BeautifulSoup] parse tree into a nicely
  /// formatted Unicode string, with a separate line for each tag and
  /// each string.
  ///
  /// You can call [_prettify] on the top-level BeautifulSoup object, or on
  /// any of its element objects.
  ///
  /// Since it adds whitespace (in the form of newlines), [_prettify] changes
  /// the meaning of an HTML document and should not be used to reformat one.
  ///
  /// The goal of [_prettify] is to help you visually understand the structure
  /// of the documents you work with.
  void _prettify();

  /// {@template output_getText}
  /// Returns the text of an element.
  ///
  /// Same like `bs4element.string`.
  /// {@endtemplate}
  String getText();

  /// {@macro output_getText}
  String get text;

  /// Returns the whole element's representation as a [String].
  String toString();
}
