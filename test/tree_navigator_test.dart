import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:html/dom.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  late BeautifulSoup bs;

  setUp(() {
    bs = BeautifulSoup(html_doc);
  });

  group('TreeNavigator', () {
    group('children', () {
      test("finds all element's children", () {
        final bs4 = bs.body?.children;
        expect(bs4, isNotNull);
        expect(bs4!.length, 3);
        expect(
          bs4.map((e) => e.name),
          equals(<String>['p', 'p', 'p']),
        );
      });

      test("does not have children", () {
        final bs4 = bs.title?.children;
        expect(bs4, isNotNull);
        expect(bs4!.length, 0);
      });
    });

    group('contents', () {
      // same as children
      test("finds all element's contents", () {
        final bs4 = bs.body?.contents;
        expect(bs4, isNotNull);
        expect(bs4!.length, 3);
        expect(
          bs4.map((e) => e.name),
          equals(<String>['p', 'p', 'p']),
        );
      });

      test("does not have content", () {
        final bs4 = bs.title?.contents;
        expect(bs4, isNotNull);
        expect(bs4!.length, 0);
      });
    });

    group('descendants', () {
      test("finds all element's descendants", () {
        final bs4 = bs.body?.descendants;
        expect(bs4, isNotNull);
        expect(bs4!.length, 8);
        expect(
          bs4.map((e) => e.name),
          equals(<String>['p', 'b', 'p', 'a', 'a', 'a', 'a', 'p']),
        );
      });

      test("does not have descendants", () {
        final bs4 = bs.title?.descendants;
        expect(bs4, isNotNull);
        expect(bs4!.length, 0);
      });
    });

    group('string', () {
      test("finds element's text", () {
        final bs4 = bs.title;
        expect(bs4, isNotNull);
        expect(bs4!.string, equals("The Dormouse's story"));
      });

      test("finds unstripped strings", () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        expect(bs4, isNotNull);

        final str = bs4!.string;
        expect(str, startsWith("Once upon a time there were"));

        final strLines = str.split('\n');
        expect(strLines[0], startsWith('Once upon a time there were'));
        expect(strLines[1], startsWith('     '));
        expect(strLines[2], startsWith('     '));
        expect(strLines[3], startsWith('     '));
      });

      test("does not find text", () {
        bs = BeautifulSoup(html_prettify);
        final bs4 = bs.head;
        expect(bs4, isNotNull);
        expect(bs4!.string, equals(''));
      });
    });

    group('strippedStrings', () {
      test("finds regular text normally", () {
        final bs4 = bs.title;
        expect(bs4, isNotNull);
        expect(bs4!.strippedStrings, equals("The Dormouse's story"));
      });

      test("finds stripped strings", () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        expect(bs4, isNotNull);

        final str = bs4!.strippedStrings;
        expect(str, startsWith("Once upon a time there were"));

        final strLines = str.split('\n');
        expect(strLines[0], startsWith('Once upon a time there were'));
        expect(strLines[1], startsWith('Elsie'));
        expect(strLines[2], startsWith('Lacie'));
        expect(strLines[3], startsWith('Tillie'));
      });

      test("does not find text", () {
        bs = BeautifulSoup(html_prettify);
        final bs4 = bs.head;
        expect(bs4, isNotNull);
        expect(bs4!.strippedStrings, equals(''));
      });
    });

    group('parent', () {
      test("finds element's parent", () {
        final bs4 = bs.body?.p;
        expect(bs4, isNotNull);

        final parent = bs4!.parent;
        expect(parent, isNotNull);
        expect(parent!.name, equals('body'));
        expect(parent.children.length, 3);
      });

      test("does not have parent", () {
        bs = BeautifulSoup.fragment(html_placeholder);
        final bs4 = bs.findFirstAny();
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('a'));
        expect(bs4.parent, isNull);
      });
    });

    group('parents', () {
      test("finds all element's parents", () {
        final bs4 = bs.body?.p;
        expect(bs4, isNotNull);

        final parents = bs4!.parents;
        expect(parents, isNotEmpty);
        expect(parents.length, 2);
        expect(
          parents.map((e) => e.name),
          equals(<String>['body', 'html']),
        );
      });

      test("does not have parents", () {
        bs = BeautifulSoup.fragment(html_placeholder);
        final bs4 = bs.findFirstAny();
        expect(bs4, isNotNull);
        expect(bs4!.parents, isEmpty);
      });
    });

    group('previousSibling', () {
      test("finds element's previous sibling", () {
        final bs4 = bs.body;
        expect(bs4, isNotNull);

        final prevSibling = bs4!.previousSibling;
        expect(prevSibling, isNotNull);
        expect(prevSibling!.name, equals('head'));
      });

      test("does not have previous sibling", () {
        final bs4 = bs.head;
        expect(bs4, isNotNull);

        final prevSibling = bs4!.previousSibling;
        expect(prevSibling, isNull);
      });
    });

    group('previousSiblings', () {
      test("finds all element's previous siblings", () {
        final bs4 = bs.find('a', attrs: {'id': 'link3'});
        expect(bs4, isNotNull);

        final prevSiblings = bs4!.previousSiblings;
        expect(prevSiblings.length, 2);
        expect(
          prevSiblings.map((e) => e.name),
          equals(<String>['a', 'a']),
        );
        expect(
          prevSiblings.map((e) => e.id),
          equals(<String>['link2', 'link1']),
        );
      });

      test("does not have previous siblings", () {
        final bs4 = bs.head;
        expect(bs4, isNotNull);
        expect(bs4!.previousSiblings, isEmpty);
      });
    });

    group('nextSibling', () {
      test("finds element's next sibling", () {
        final bs4 = bs.p;
        expect(bs4, isNotNull);

        final nextSibling = bs4!.nextSibling;
        expect(nextSibling, isNotNull);
        expect(nextSibling!.name, equals('p'));
        expect(nextSibling.className, equals('story'));
        expect(nextSibling.string, startsWith("Once upon a time there"));
      });

      test("does not have next sibling", () {
        final bs4 = bs.body;
        expect(bs4, isNotNull);

        final nextSibling = bs4!.nextSibling;
        expect(nextSibling, isNull);
      });
    });

    group('nextSiblings', () {
      test("finds all element's next siblings", () {
        final bs4 = bs.a;
        expect(bs4, isNotNull);

        final nextSiblings = bs4!.nextSiblings;
        expect(nextSiblings.length, 3);
        expect(
          nextSiblings.map((e) => e.name),
          equals(<String>['a', 'a', 'a']),
        );
        expect(
          nextSiblings.map((e) => e.id),
          equals(<String>['link2', 'link3', '']),
        );
      });

      test("does not have next siblings", () {
        final bs4 = bs.body;
        expect(bs4, isNotNull);
        expect(bs4!.nextSiblings, isEmpty);
      });
    });

    group('nextElement', () {
      test("finds next element, within children", () {
        final bs4 = bs.body!.find('p', attrs: {'class': 'story'});
        expect(bs4, isNotNull);

        final nextElement = bs4!.nextElement;
        expect(nextElement, isNotNull);
        expect(
          nextElement.toString(),
          equals(
              '<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>'),
        );
      });

      test("finds next element, within next sibling", () {
        final bs4 = bs.body!.find('a', attrs: {'id': 'link3'});
        expect(bs4, isNotNull);

        final nextElement = bs4!.nextElement;
        expect(nextElement, isNotNull);
        expect(
          nextElement.toString(),
          equals('<a href="unknown">Some name</a>'),
        );
      });

      test("finds next element, within parent next sibling", () {
        final bs4 = bs.body!.p!.find('b');
        expect(bs4, isNotNull);

        final nextElement = bs4!.nextElement;
        expect(nextElement, isNotNull);
        expect(nextElement!.name, equals('p'));
        expect(nextElement['class'], equals('story'));
      });

      test("does not find next element (bottom most element)", () {
        final bs4 = bs.findAll('p', attrs: {'class': 'story'}).last;
        expect(bs4.toString(), equals('<p class="story">...</p>'));

        final nextElement = bs4.nextElement;
        expect(nextElement, isNull);
      });
    });

    group('nextElements', () {
      test("finds next elements, within children and next siblings", () {
        final bs4 = bs.body!.find('p', attrs: {'class': 'story'});
        expect(bs4, isNotNull);

        final nextElements = bs4!.nextElements;
        expect(nextElements, isNotEmpty);
        expect(nextElements.length, 5);
        expect(
          nextElements.map((e) => e.name),
          equals(<String>['a', 'a', 'a', 'a', 'p']),
        );
      });

      test("finds next elements, within parent and next siblings", () {
        final bs4 = bs.body!.p!.find('b');
        expect(bs4, isNotNull);

        final nextElements = bs4!.nextElements;
        expect(nextElements, isNotEmpty);
        expect(nextElements.length, 2);
        expect(nextElements.map((e) => e.name), equals(<String>['p', 'p']));
        expect(nextElements[0].string, startsWith('Once upon a time'));
        expect(nextElements[1].string, equals('...'));
      });

      test("does not find next elements", () {
        final bs4 = bs.findAll('p', attrs: {'class': 'story'}).last;
        expect(bs4, isNotNull);

        final nextElements = bs4.nextElements;
        expect(nextElements, isEmpty);
      });
    });

    group('previousElement', () {
      test("finds previous element, within previous sibling", () {
        final bs4 = bs.body!.find('p', attrs: {'class': 'story'});
        expect(bs4, isNotNull);

        final previousElement = bs4!.previousElement;
        expect(previousElement, isNotNull);
        expect(
          previousElement.toString(),
          equals("<p class=\"title\"><b>The Dormouse's story</b></p>"),
        );
      });

      test("finds previous element, within parent", () {
        final bs4 = bs.body!.p!.find('b');
        expect(bs4, isNotNull);

        final previousElement = bs4!.previousElement;
        expect(previousElement, isNotNull);
        expect(
          previousElement.toString(),
          equals("<p class=\"title\"><b>The Dormouse's story</b></p>"),
        );
      });

      test("does not find previous element (top most element)", () {
        final bs4 = bs.html;
        expect(bs4, isNotNull);

        final previousElement = bs4!.previousElement;
        expect(previousElement, isNull);
      });
    });

    group('previousElements', () {
      test("finds previous elements, within previous siblings and parent", () {
        final bs4 = bs.body!.find('p', attrs: {'class': 'story'});
        expect(bs4, isNotNull);

        final previousElements = bs4!.previousElements;
        expect(previousElements, isNotEmpty);
        expect(previousElements.length, 4);
        expect(
          previousElements.map((e) => e.name),
          equals(<String>['p', 'body', 'head', 'html']),
        );
      });

      test("finds previous elements, within parent", () {
        final bs4 = bs.head!.title;
        expect(bs4, isNotNull);

        final previousElements = bs4!.previousElements;
        expect(previousElements, isNotEmpty);
        expect(previousElements.length, 2);
        expect(
          previousElements.map((e) => e.name),
          equals(<String>['head', 'html']),
        );
      });

      test("does not find previous elements", () {
        final bs4 = bs.html;
        expect(bs4, isNotNull);

        final previousElements = bs4!.previousElements;
        expect(previousElements, isEmpty);
      });
    });

    group('nextParsed', () {
      setUp(() {
        bs = BeautifulSoup.fragment(html_comment);
      });

      test("finds next parsed element, within parent", () {
        final bs4 = bs.find('br');
        expect(bs4, isNotNull);

        final nextParsed = bs4!.nextParsed;
        expect(nextParsed, isNotNull);
        expect(nextParsed!.data, equals('<tag></tag>'));
        expect(nextParsed.nodeType, Node.ELEMENT_NODE);
      });

      test("finds next parsed text, within children", () {
        final bs4 = bs.find('c');
        expect(bs4, isNotNull);

        final nextParsed = bs4!.nextParsed;
        expect(nextParsed, isNotNull);
        expect(nextParsed!.data, equals('text2'));
        expect(nextParsed.nodeType, Node.TEXT_NODE);
      });

      test("finds next parsed comment, within next siblings", () {
        final bs4 = bs.find('b');
        expect(bs4, isNotNull);

        final nextParsed = bs4!.nextParsed;
        expect(nextParsed, isNotNull);
        expect(nextParsed!.data, equals('<!-- some comment -->'));
        expect(nextParsed.nodeType, Node.COMMENT_NODE);
      });

      test("does not find next parsed (bottom most element)", () {
        bs = BeautifulSoup.fragment(html_placeholder_empty);
        final bs4 = bs.a;
        expect(bs4, isNotNull);

        final nextParsed = bs4!.nextParsed;
        expect(nextParsed, isNull);
      });
    });

    group('prevParsedAll', () {
      setUp(() {
        bs = BeautifulSoup.fragment(html_comment);
      });

      test(
          "finds all next parsed elements, within children, "
          "parent and next sibling", () {
        final bs4 = bs.find('b');
        expect(bs4, isNotNull);

        final nextParsedAll = bs4!.nextParsedAll;
        expect(nextParsedAll, isNotEmpty);
        expect(nextParsedAll.length, 7);

        expect(nextParsedAll[0].data, equals('<!-- some comment -->'));
        expect(nextParsedAll[0].nodeType, Node.COMMENT_NODE);

        expect(nextParsedAll[1].data, equals('<c>text2</c>'));
        expect(nextParsedAll[1].nodeType, Node.ELEMENT_NODE);

        expect(nextParsedAll[2].data, startsWith('\n'));
        expect(nextParsedAll[2].nodeType, Node.TEXT_NODE);

        expect(nextParsedAll[3].data, equals('<br>'));
        expect(nextParsedAll[3].nodeType, Node.ELEMENT_NODE);

        expect(nextParsedAll[4].data, equals('<tag></tag>'));
        expect(nextParsedAll[4].nodeType, Node.ELEMENT_NODE);

        expect(nextParsedAll[5].data, startsWith('\n'));
        expect(nextParsedAll[5].nodeType, Node.TEXT_NODE);

        expect(nextParsedAll[6].data, startsWith('\n'));
        expect(nextParsedAll[6].nodeType, Node.TEXT_NODE);
      });
    });

    group('previousParsed', () {
      setUp(() {
        bs = BeautifulSoup.fragment(html_comment);
      });

      test("finds prev parsed element, within prev siblings", () {
        final bs4 = bs.find('c');
        expect(bs4, isNotNull);

        final prevParsed = bs4!.previousParsed;
        expect(prevParsed, isNotNull);
        expect(prevParsed!.data, equals('<!-- some comment -->'));
        expect(prevParsed.nodeType, Node.COMMENT_NODE);
      });

      test("finds prev parsed element, within parent", () {
        bs = BeautifulSoup(html_prettify);
        final bs4 = bs.head;
        expect(bs4, isNotNull);

        final prevParsed = bs4!.previousParsed;
        expect(prevParsed, isNotNull);
        expect(prevParsed!.data, startsWith('<html>'));
        expect(prevParsed.nodeType, Node.DOCUMENT_NODE);
      });

      test("does not find prev parsed (top most element)", () {
        final bs4 = bs.find('x');
        expect(bs4, isNotNull);

        final prevParsed = bs4!.previousParsed;
        expect(prevParsed, isNull);
      });
    });

    group('previousParsedAll', () {
      setUp(() {
        bs = BeautifulSoup.fragment(html_comment);
      });

      test(
          "finds all prev parsed elements, within children, "
          "parent and prev sibling", () {
        final bs4 = bs.find('c');
        expect(bs4, isNotNull);

        final prevParsedAll = bs4!.previousParsedAll;
        expect(prevParsedAll, isNotEmpty);
        expect(prevParsedAll.length, 5);

        expect(prevParsedAll[0].data, equals('<!-- some comment -->'));
        expect(prevParsedAll[0].nodeType, Node.COMMENT_NODE);

        expect(prevParsedAll[1].data, equals('<b></b>'));
        expect(prevParsedAll[1].nodeType, Node.ELEMENT_NODE);

        expect(prevParsedAll[2].data, startsWith('\n'));
        expect(prevParsedAll[2].nodeType, Node.TEXT_NODE);

        expect(prevParsedAll[3].data, startsWith('\n'));
        expect(prevParsedAll[3].nodeType, Node.TEXT_NODE);

        expect(prevParsedAll[4].data, startsWith('<x>'));
        expect(prevParsedAll[4].nodeType, Node.ELEMENT_NODE);
      });

      test("does not find prev parsed (top most element)", () {
        final bs4 = bs.find('x');
        expect(bs4, isNotNull);

        final prevParsed = bs4!.previousParsedAll;
        expect(prevParsed.length, 0);
      });
    });
  });
}
