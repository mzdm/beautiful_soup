import 'package:beautiful_soup/src/shared.dart';
import 'package:html/parser.dart';

/// {@template bs_soup}
/// Beautiful Soup is a library for pulling data out of HTML files.
/// It provides ways of navigating, searching, and modifying the parse tree.
/// It commonly saves programmers hours or days of work.
///
/// How it should be used?
///
/// **1.** parse a document
///
/// ```
/// BeautifulSoup bs = BeautifulSoup(html_doc_string);
/// BeautifulSoup bs = BeautifulSoup.fragment(html_doc_string); // if it is just a part of html
/// ```
///
/// **2.** navigate quickly to any element
///
/// ```
/// Bs4Element bs4 = bs.body.p; // quickly with tags
/// Bs4Element bs4 = bs.find('p', attrs: {'class': 'story'}); // with query func
/// ```
///
/// **3.** perform any other actions
///
/// ```
/// bs4.name; // get tag name
/// bs4.string; // get text
/// bs4.toString(); // get String representation of this element, same as outerHtml
/// bs4.innerHtml; // get html elements inside the element
/// bs4.className; // get class attribute value
/// bs4['class']; // get class attribute value
/// bs4['class'] = 'board'; // change class attribute value to 'board'
/// bs4.children; // get all element's children elements
/// bs4.replaceWith(otherBs4Element); // replace with other element
/// ```
///
/// and many more!
/// {@endtemplate}
class BeautifulSoup extends Shared {
  /// {@macro bs_soup}
  BeautifulSoup(String html_doc) {
    doc = parse(html_doc);
  }

  /// {@macro bs_soup}
  BeautifulSoup.fragment(String html_doc) {
    doc = parseFragment(html_doc);
  }

  @override
  String toString() => doc.outerHtml;
}
