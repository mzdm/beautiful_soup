// ignore_for_file: non_constant_identifier_names
import 'package:html/dom.dart';

import '../bs4_element.dart';

/// Contains methods from [Searching the tree](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#searching-the-tree).
abstract class ITreeSearcher {
  /// Returns the top most (first) element of the parse tree, of any tag type.
  Bs4Element? findFirstAny();

  /// Looks through a tag’s descendants and retrieves all descendants
  /// that match your filters.
  ///
  /// {@template tree_searcher_find}
  /// Filters:
  ///
  /// \- [name], the tag name, use asterisk (*) to search any tag.
  ///
  /// \- [class_], search by CSS class. Remember that a single tag can have
  /// multiple values for its “class” attribute. When you search for a tag
  /// that matches a certain CSS class, you’re matching against
  /// any of its CSS classes.
  ///
  /// For example for HTML `'<p class="body strikeout"></p>'`
  ///
  /// 1) `class_: 'body'` ... matches
  ///
  /// 2) `class_: 'body strikeout'` ... matches
  ///
  /// 3) `class_: 'strikeout body'` ... does not match (different order)
  ///
  /// \- [id], search by 'id' attribute.
  ///
  /// \- [attrs], for specifying the attributes of a tag, where **key** is
  /// **name of the attribute** and **value** is the **value of the attribute**
  /// (the only allowed types of the value are **String** or **bool**).
  /// Use `true` as value of an attribute to search for any attribute values.
  ///
  /// \- [regex], search for element names, via [Pattern].
  ///
  /// For example: `regex: r'^b'` ... will search for  &lt;b&gt;, &lt;body&gt;, etc. elements.
  ///
  /// \- [string], search for strings (text) inside of elements, via [Pattern].
  ///
  /// For example: `string: r'^Article #\d*'`
  ///
  /// \- [limit], to take only a certain number of results.
  /// {@endtemplate}
  ///
  /// For example:
  /// ```
  /// bs.findAll('p', class_: 'story'); // finds all "p" elements which have defined "story" attribute with "story" value
  /// bs.findAll('p', attrs: {'title': 'Copy'}); // finds all "p" elements which have defined "title" attribute with "Copy" value
  /// bs.findAll('*', attrs: {'class': true}); // finds all elements of any tag which have defined "class" attribute
  /// bs.findAll(customSelector: '.nav_bar'); // find all with custom selector
  /// ```
  ///
  /// {@template tree_searcher_find2}
  /// <br>
  /// You can provide your own CSS [selector](https://drafts.csswg.org/selectors-4/#overview)
  /// [selector], if it is specified then both [name] and [attrs]
  /// will be ignored. If such selector is not implemented this method
  /// will throw [UnimplementedError].
  ///
  /// Use `true` as an attribute value to search any value.
  /// {@endtemplate}
  List<Bs4Element> findAll(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  });

  /// Looks through a tag’s descendants and retrieves descendant
  /// that matches your filters.
  ///
  /// For example:
  /// ```
  /// bs.find('*', class_: 'story'); // any element with "class" attribute "story"
  /// bs.find('p', id: 'dialog-content');
  /// bs.find('button', attrs: {'title': 'Copy'});
  /// ```
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  Bs4Element? find(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  });

  /// {@template tree_searcher_findParent}
  /// [findAll] and [find] work their way down the tree, looking at tag’s
  /// descendants.
  ///
  /// These methods do the opposite: they work their way up the
  /// tree, looking at a tag’s parents.
  /// {@endtemplate}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  Bs4Element? findParent(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  });

  /// {@macro tree_searcher_findParent}
  ///
  /// Returns a list of parents.
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findParents(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  });

  /// {@template tree_searcher_findNextSibling}
  /// These methods use [nextSiblings] to iterate over the rest of an element’s
  /// siblings in the tree.
  ///
  /// The [findNextSiblings] method returns all the
  /// siblings that match, and [findNextSibling] only returns the first one.
  /// {@endtemplate}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  Bs4Element? findNextSibling(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  });

  /// {@macro tree_searcher_findNextSibling}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findNextSiblings(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  });

  /// {@template tree_searcher_findPreviousSibling}
  /// These methods use [previousSiblings] to iterate over an element’s
  /// siblings that precede it in the tree.
  ///
  /// The [findPreviousSiblings]
  /// method returns all the siblings that match, and [findPreviousSibling]
  /// only returns the first one.
  /// {@endtemplate}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  Bs4Element? findPreviousSibling(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  });

  /// {@macro tree_searcher_findPreviousSibling}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findPreviousSiblings(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  });

  /// {@template tree_searcher_findNextElement}
  /// These methods use [nextElements] to iterate over elements
  /// that come after it in the document.
  ///
  /// The [findAllNextElements] method returns all matches,
  /// and [findNextElement] only returns the first match.
  /// {@endtemplate}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  Bs4Element? findNextElement(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  });

  /// {@macro tree_searcher_findNextElement}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findAllNextElements(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  });

  /// {@template tree_searcher_findPreviousElement}
  /// These methods use [previousElements] to iterate over the tags and
  /// strings that came before it in the document.
  ///
  /// The [findAllPreviousElements] method returns all matches,
  /// and [findPreviousElement] only returns the first match.
  /// {@endtemplate}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  Bs4Element? findPreviousElement(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
  });

  /// {@macro tree_searcher_findPreviousElement}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findAllPreviousElements(
    String name, {
    String? id,
    String? class_,
    Map<String, Object>? attrs,
    Pattern? regex,
    Pattern? string,
    String? selector,
    int? limit,
  });

  /// {@template tree_searcher_findNextParsed}
  /// These methods use [nextParsed] to iterate over the tags, comments,
  /// strings, etc. that came after it in the document.
  ///
  /// The [findNextParsedAll] method returns all matches,
  /// and [findNextParsed] only returns the first match.
  /// {@endtemplate}
  ///
  /// {@template tree_searcher_find3Parse}
  /// Filters:
  ///
  /// \- [pattern], to search only for occurrences that satisfy
  /// the RegExp match.
  ///
  /// \- [nodeType], what type of node/element to search.
  ///   * Node.ATTRIBUTE_NODE = 2;
  ///   * Node.CDATA_SECTION_NODE = 4;
  ///   * Node.COMMENT_NODE = 8;
  ///   * Node.DOCUMENT_FRAGMENT_NODE = 11;
  ///   * Node.DOCUMENT_NODE = 9;
  ///   * Node.DOCUMENT_TYPE_NODE = 10;
  ///   * Node.ELEMENT_NODE = 1;
  ///   * Node.ENTITY_NODE = 6;
  ///   * Node.ENTITY_REFERENCE_NODE = 5;
  ///   * Node.NOTATION_NODE = 12;
  ///   * Node.PROCESSING_INSTRUCTION_NODE = 7;
  ///   * Node.TEXT_NODE = 3;
  ///
  ///
  /// ```
  /// // find all url links within the text node
  /// final nextParsed = bs.findNextParsed(
  ///   pattern: RegExp(r'.*(.com)'),
  ///   nodeType: Node.TEXT_NODE,
  /// );
  /// ```
  /// {@endtemplate}
  Node? findNextParsed({
    RegExp? pattern,
    int? nodeType,
  });

  /// {@macro tree_searcher_findNextParsed}
  ///
  /// {@macro tree_searcher_find3Parse}
  List<Node> findNextParsedAll({
    RegExp? pattern,
    int? nodeType,
    int? limit,
  });

  /// {@template tree_searcher_findPreviousParsed}
  /// These methods use [previousParsed] to iterate over the tags, comments,
  /// strings, etc. that came before it in the document.
  ///
  /// The [findPreviousParsedAll] method returns all matches,
  /// and [findPreviousParsed] only returns the first match.
  /// {@endtemplate}
  ///
  /// {@macro tree_searcher_find3Parse}
  Node? findPreviousParsed({
    RegExp? pattern,
    int? nodeType,
  });

  /// {@macro tree_searcher_findPreviousParsed}
  ///
  /// {@macro tree_searcher_find3Parse}
  List<Node> findPreviousParsedAll({
    RegExp? pattern,
    int? nodeType,
    int? limit,
  });
}
