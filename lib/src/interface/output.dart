import '../bs_soup.dart';

/// Contains methods from [Output](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#output).
// TODO: improve prettify
abstract class IOutput {
  /// The method will turn a [BeautifulSoup] parse tree into a nicely
  /// formatted [String], with a separate line for each tag and
  /// each string.
  ///
  /// You can call [prettify] on the top-level BeautifulSoup object, or on
  /// any of its element objects.
  ///
  /// Since it adds whitespace (in the form of newlines), [prettify] changes
  /// the meaning of an HTML document and should not be used to reformat one.
  ///
  /// The **goal** of [prettify] is to **help you visually understand the structure**
  /// of the documents you work with.
  String prettify();

  /// {@template output_getText}
  /// Returns the text of an element.
  ///
  /// Same like `bs4element.string`.
  /// {@endtemplate}
  ///
  /// \- [separator] - Strings will be concatenated using this separator.
  ///
  /// \- [strip] If `true`, strings will be stripped before being concatenated
  /// (strips whitespace from the beginning and end of each bit of text).
  /// `false` by default.
  String getText({String separator, bool strip});

  /// {@macro output_getText}
  String get text;

  /// Returns the whole element's representation as a [String].
  @override
  String toString();
}
