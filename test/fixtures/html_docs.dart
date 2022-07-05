// ignore_for_file: constant_identifier_names

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

const html_heading = "<h1>This is heading 1</h1>";

const html_placeholder = "<a>text</a>";

const html_placeholder_empty = "<a></a>";

const html_plain_text = "text";

const html_comment = """
<x>
<a>
  <b></b><!-- some comment --><c>text2</c>
  <br></a><tag></tag>
</x>
""";

const html_prettify = """
<html><head><body><a href="http://example.com/">I linked to <i>example.com</i></a></body></html>
""";
