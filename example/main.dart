import 'package:beautiful_soup/beautiful_soup.dart';

const html_doc = """
<html>
   <head>
      <title>The Dormouse's story</title>
   </head>
   <body>
      <p class="title"><b>The Dormouse's story</b></p>
      <p class="story">Once upon a time there were three little sisters; and their names were
         <a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>,
         <a href="http://example.com/lacie" class="sister" id="link2">Lacie</a> and
         <a class="sister" id="link3">Tillie</a>;
         and they lived at the bottom of a well.
         <a href="unknown">Some name</a>
      </p>
      <p class="story">...</p>
   </body>
</html>
""";

void main() {
  // 1. parse a document
  BeautifulSoup bs = BeautifulSoup(html_doc); // use BeautifulSoup.fragment(html_doc_string) if you parse a part of html

  // 2. navigate quickly to any element
  bs.body!.a!; // get String representation of this element, same as outerHtml, finds: "<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>"
  Bs4Element bs4 = bs.body!.p!; // quickly with tags, finds and navigates to: "<p class="title"><b>The Dormouse's story</b></p>"

  // 3. perform any other actions for the navigated element
  bs4.name; // get tag name, finds: "p"
  bs4.string; // get text, finds: "The Dormouse's story";
  bs4.innerHtml; // get html elements inside the element, finds: "<b>The Dormouse's story</b>"
  bs4.className; // get class attribute value, finds: "title"
  bs4['id']; // get class attribute value, finds: null
  bs4['class'] = 'board'; // change class attribute value to 'board'

  Bs4Element bs4Alt = bs.find('p', attrs: {'class': 'story'})!; // with query func you can specify attributes
  bs4.replaceWith(bs4Alt); // replace with other element
  bs4Alt.children; // get all element's children elements, finds: list with four "a" elements
}
