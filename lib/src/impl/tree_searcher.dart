import 'package:html/dom.dart';

import '../bs4_element.dart';

/// Contains methods from [Searching the tree](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#searching-the-tree).
abstract class TreeSearcherImpl {
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
  /// \- [attrs], for specifying the attributes of a tag, where **key** is
  /// **name of the attribute** and **value** is the **value of the attribute**
  /// (the only allowed types of the value are **String** or **bool**).
  /// Use `true` as value of an attribute to search for any attribute values.
  /// {@endtemplate}
  ///
  /// For example:
  /// ```
  /// bs.findAll('p', attrs: {'class': 'story'}); // finds all "p" elements which have defined "class" attribute with "story" value
  /// bs.findAll('*', attrs: {'class': true}); // finds all elements of any tag which have defined "class" attribute
  /// bs.findAll(customSelector: '.nav_bar'); // find all with custom selector
  /// ```
  ///
  /// {@template tree_searcher_find2}
  /// <br>
  /// You can provide your own CSS [selector](https://drafts.csswg.org/selectors-4/#overview)
  /// [customSelector], if it is specified then both [name] and [attrs]
  /// will be ignored. If such selector is not implemented this method
  /// will throw [UnimplementedError].
  ///
  /// Use `true` as an attribute value to search any value.
  /// {@endtemplate}
  List<Bs4Element> findAll(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
  });

  /// Looks through a tag’s descendants and retrieves descendant
  /// that matches your filters.
  ///
  /// For example:
  /// ```
  /// bs.find('p', attrs: {'class': 'story'});
  /// ```
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  Bs4Element? find(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
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
    Map<String, Object>? attrs,
    String? customSelector,
  });

  /// {@macro tree_searcher_findParent}
  ///
  /// Returns a list of parents.
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findParents(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
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
    Map<String, Object>? attrs,
    String? customSelector,
  });

  /// {@macro tree_searcher_findNextSibling}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findNextSiblings(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
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
    Map<String, Object>? attrs,
    String? customSelector,
  });

  /// {@macro tree_searcher_findPreviousSibling}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findPreviousSiblings(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
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
    Map<String, Object>? attrs,
    String? customSelector,
  });

  /// {@macro tree_searcher_findNextElement}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findAllNextElements(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
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
    Map<String, Object>? attrs,
    String? customSelector,
  });

  /// {@macro tree_searcher_findPreviousElement}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Bs4Element> findAllPreviousElements(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
  });

  /// {@template tree_searcher_findNextParsed}
  /// These methods use [nextParsed] to iterate over the tags, comments,
  /// strings, etc. that came after it in the document.
  ///
  /// The [findNextParsedAll] method returns all matches,
  /// and [findNextParsed] only returns the first match.
  /// {@endtemplate}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  Node? findNextParsed({RegExp? pattern, int? nodeType});

  /// {@macro tree_searcher_findNextParsed}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  List<Node> findNextParsedAll({RegExp? pattern, int? nodeType});

  /// {@template tree_searcher_findPreviousParsed}
  /// These methods use [previousParsed] to iterate over the tags, comments,
  /// strings, etc. that came before it in the document.
  ///
  /// The [findPreviousParsedAll] method returns all matches,
  /// and [findPreviousParsed] only returns the first match.
  /// {@endtemplate}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  Node? findPreviousParsed({RegExp? pattern, int? nodeType});

  /// {@macro tree_searcher_findPreviousParsed}
  ///
  /// {@macro tree_searcher_find}
  /// {@macro tree_searcher_find2}
  /// // TODO: Update docs to new parameters
  List<Node> findPreviousParsedAll({RegExp? pattern, int? nodeType});
}
