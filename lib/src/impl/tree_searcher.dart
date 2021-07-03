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
  /// When you search for a tag that matches a certain CSS class,
  /// you’re matching against any of its CSS classes.
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
  /// You can provide your own [selector](https://drafts.csswg.org/selectors-4/#overview)
  /// [customSelector], if it is specified then both [name] and [attrs]
  /// will be ignored. If such selector is not implemented this method
  /// will throw [UnimplementedError].
  ///
  /// Use `true` as an attribute value to search any value.
  /// {@endtemplate}
  List<Bs4Element> findAll(
    String name, {
    Map<String, Object> attrs,
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
  Bs4Element? _findParent();

  /// {@macro tree_searcher_findParent}
  List<Bs4Element> _findParents();

  /// {@template tree_searcher_findNextSibling}
  /// These methods use [nextSiblings] to iterate over the rest of an element’s
  /// siblings in the tree.
  ///
  /// The [findNextSiblings] method returns all the
  /// siblings that match, and [findNextSibling] only returns the first one.
  /// {@endtemplate}
  Bs4Element? _findNextSibling();

  /// {@macro tree_searcher_findNextSibling}
  List<Bs4Element> _findNextSiblings();

  /// {@template tree_searcher_findPreviousSibling}
  /// These methods use [previousSiblings] to iterate over an element’s
  /// siblings that precede it in the tree.
  ///
  /// The [findPreviousSiblings]
  /// method returns all the siblings that match, and [findPreviousSibling]
  /// only returns the first one.
  /// {@endtemplate}
  Bs4Element? _findPreviousSibling();

  /// {@macro tree_searcher_findPreviousSibling}
  List<Bs4Element> _findPreviousSiblings();

  /// {@template tree_searcher_findNext}
  /// These methods use [nextElements] to iterate over whatever tags and
  /// strings that come after it in the document.
  ///
  /// The [findAllNext] method returns all matches, and [findNext]
  /// only returns the first match.
  /// {@endtemplate}
  Bs4Element? _findNext();

  /// {@macro tree_searcher_findNext}
  List<Bs4Element> _findAllNext();

  /// {@template tree_searcher_findPrevious}
  /// These methods use [previousElements] to iterate over the tags and
  /// strings that came before it in the document.
  ///
  /// The [findAllPrevious] method returns all matches, and [findPrevious]
  /// only returns the first match.
  /// {@endtemplate}
  Bs4Element? _findPrevious();

  /// {@macro tree_searcher_findPrevious}
  List<Bs4Element> _findAllPrevious();
}
