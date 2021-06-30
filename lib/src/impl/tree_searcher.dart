import '../bs4_element.dart';

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
  ///
  /// For example:
  /// ```
  /// bs.find('p', attrs: {'class': 'story'});
  /// ```
  ///
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
  /// {@macro tree_searcher_find}
  Bs4Element? find(
    String name, {
    Map<String, Object>? attrs,
    String? customSelector,
  });

  Bs4Element? _findParent();

  List<Bs4Element> _findParents();

  Bs4Element? _findNextSibling();

  List<Bs4Element> _findNextSiblings();

  Bs4Element? _findPreviousSibling();

  List<Bs4Element> _findPreviousSiblings();

  Bs4Element? _findNext();

  List<Bs4Element> _findAllNext();

  Bs4Element? _findPrevious();

  List<Bs4Element> _findAllPrevious();
}
