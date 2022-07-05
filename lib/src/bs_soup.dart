// ignore_for_file: non_constant_identifier_names

import 'package:beautiful_soup_dart/src/bs4_element.dart';
import 'package:beautiful_soup_dart/src/extensions.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'shared.dart';

/// {@template bs_soup}
/// Beautiful Soup is a library for pulling data out of HTML files.
/// It provides ways of navigating, searching, and modifying the parse tree.
/// It commonly saves programmers hours or days of work.
///
/// How it should be used? 3 easy steps.
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
/// Bs4Element bs4 = bs.find('p', class_: 'story'); // finds first element with html tag "p" and which has "class" attribute with value "story"
/// Bs4Element bs4 = bs.findAll('a', attrs: {'class': true}); // finds all elements with html tag "a" and which have defined "class" attribute with whatever value
/// Bs4Element bs4 = bs.find('', selector: '#link1'); // find with custom CSS selector (other parameters are ignored)
/// Bs4Element bs4 = bs.find('*', id: 'link1'); // find by id
/// Bs4Element bs4 = bs.find('*', regex: r'^b'); // find any element which tag starts with "b", for example: body, b, ...
/// Bs4Element bs4 = bs.find('p', string: r'^Article #\d*'); // find "p" element which text starts with "Article #[number]"
/// Bs4Element bs4 = bs.find('a', attrs: {'href': 'http://example.com/elsie'}); // finds by "href" attribute
/// ```
///
/// **3.** perform any actions
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

  /// {@macro tree_modifier_newTag}
  static Bs4Element newTag(
    String? name, {
    Map<String, String>? attrs,
    String? string,
  }) {
    final newElement = Element.tag(name);
    if (attrs != null) {
      newElement.attributes.addAll(attrs);
    }
    newElement.text = string;
    return newElement.bs4;
  }

  @override
  String toString() => doc.outerHtml;
}
