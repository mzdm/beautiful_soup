import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  late BeautifulSoup bs;

  setUp(() {
    bs = BeautifulSoup(html_doc);
  });

  group('TreeModifier', () {
    group('set string', () {
      test('changes the text of the element', () {
        final bs4 = bs.title;
        expect(bs4, isNotNull);
        expect(bs4!.string, equals("The Dormouse's story"));

        bs4.string = 'This it Title';
        expect(bs4.string, equals('This it Title'));

        // other element's texts are unchanged
        final p = bs.p;
        expect(p, isNotNull);
        expect(p!.string, equals("The Dormouse's story"));
      });
    });

    group('append', () {
      test('appends an element to the current one', () {
        final bs4 = bs.p;
        final anotherElement = BeautifulSoup.fragment(html_heading).h1;
        expect(bs4, isNotNull);
        expect(
          bs4!.outerHtml,
          equals("<p class=\"title\"><b>The Dormouse's story</b></p>"),
        );
        expect(
          anotherElement!.outerHtml,
          equals("<h1>This is heading 1</h1>"),
        );
        expect(anotherElement, isNotNull);

        bs4.append(anotherElement);
        expect(
          bs4.outerHtml,
          equals(
              "<p class=\"title\"><b>The Dormouse's story</b><h1>This is heading 1</h1></p>"),
        );
      });
    });

    group('extend', () {
      test('appends elements to the current one', () {
        final bs4 = bs.p;
        final anotherElement = BeautifulSoup.fragment(html_heading).h1;
        final anotherElement2 = BeautifulSoup.fragment(html_placeholder).a;
        expect(bs4, isNotNull);
        expect(
          bs4!.outerHtml,
          equals("<p class=\"title\"><b>The Dormouse's story</b></p>"),
        );
        expect(anotherElement, isNotNull);
        expect(anotherElement2, isNotNull);

        bs4.extend(<Bs4Element>[anotherElement!, anotherElement2!]);
        expect(
          bs4.outerHtml,
          equals(
              "<p class=\"title\"><b>The Dormouse's story</b><h1>This is heading 1</h1><a>text</a></p>"),
        );
      });
    });

    group('insert', () {
      test('inserts an element at the given position', () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        final anotherElement = bs.title;
        expect(bs4, isNotNull);
        expect(anotherElement, isNotNull);
        expect(bs4!.string, startsWith('Once upon a time'));
        expect(anotherElement!.string, equals("The Dormouse's story"));

        var firstE = bs4.children.first;
        expect(bs4.children.length, 4);
        expect(firstE.name, equals('a'));

        bs4.insert(0, anotherElement);
        expect(bs4.children.length, 5);

        firstE = bs4.children.first;
        expect(firstE.name, equals('title'));
      });

      test('throws an error if position is out of range', () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        final anotherElement = bs.title;

        expect(bs4!.children.length, 4);
        expect(() => bs4.insert(20, anotherElement!), throwsRangeError);
      });
    });

    group('insertBefore', () {
      test('inserts immediately at the beginning of the current element', () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        final anotherElement = bs.title;
        expect(bs4, isNotNull);
        expect(anotherElement, isNotNull);
        expect(bs4!.string, startsWith('Once upon a time'));
        expect(anotherElement!.string, equals("The Dormouse's story"));

        expect(bs4.children.first.name, 'a');
        expect(bs4.children.length, 4);

        bs4.insertBefore(anotherElement);
        expect(bs4.children.first.name, 'title');
        expect(bs4.children.length, 5);
        expect(
          bs4.children.map((e) => e.name),
          equals(<String>['title', 'a', 'a', 'a', 'a']),
        );
      });

      test("inserts immediately before the element's referenced position", () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        final anotherElement = bs.title;
        final lacieRefElement = bs.find('a', attrs: {'id': 'link2'});
        expect(bs4, isNotNull);
        expect(anotherElement, isNotNull);
        expect(lacieRefElement, isNotNull);
        expect(bs4!.string, startsWith('Once upon a time'));
        expect(anotherElement!.string, equals("The Dormouse's story"));
        expect(lacieRefElement!.string, equals("Lacie"));

        expect(bs4.children.first.name, 'a');
        expect(bs4.children.length, 4);

        bs4.insertBefore(anotherElement, lacieRefElement);
        expect(bs4.children[1].name, 'title');
        expect(bs4.children.length, 5);
        expect(
          bs4.children.map((e) => e.name),
          equals(<String>['a', 'title', 'a', 'a', 'a']),
        );
      });

      test(
          "throws RangeError if referenced element does not "
          "exist in the parse tree", () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        final anotherElement = bs.title;
        final refElement = bs.p;
        expect(bs4, isNotNull);
        expect(anotherElement, isNotNull);
        expect(refElement, isNotNull);

        expect(
          () => bs4!.insertBefore(anotherElement!, refElement),
          throwsRangeError,
        );
      });
    });

    group('insertAfter', () {
      test('inserts immediately at the end of the current element', () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        final anotherElement = bs.title;
        expect(bs4, isNotNull);
        expect(anotherElement, isNotNull);
        expect(bs4!.string, startsWith('Once upon a time'));
        expect(anotherElement!.string, equals("The Dormouse's story"));

        expect(bs4.children.first.name, 'a');
        expect(bs4.children.length, 4);

        bs4.insertAfter(anotherElement);
        expect(bs4.children.last.name, 'title');
        expect(bs4.children.length, 5);
        expect(
          bs4.children.map((e) => e.name),
          equals(<String>['a', 'a', 'a', 'a', 'title']),
        );
      });

      test("inserts immediately after the element's referenced position", () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        final anotherElement = bs.title;
        final lacieRefElement = bs.find('a', attrs: {'id': 'link2'});
        expect(bs4, isNotNull);
        expect(anotherElement, isNotNull);
        expect(lacieRefElement, isNotNull);
        expect(bs4!.string, startsWith('Once upon a time'));
        expect(anotherElement!.string, equals("The Dormouse's story"));
        expect(lacieRefElement!.string, equals("Lacie"));

        expect(bs4.children.first.name, 'a');
        expect(bs4.children.length, 4);

        bs4.insertAfter(anotherElement, lacieRefElement);
        expect(bs4.children[2].name, 'title');
        expect(bs4.children.length, 5);
        expect(
          bs4.children.map((e) => e.name),
          equals(<String>['a', 'a', 'title', 'a', 'a']),
        );
      });

      test(
          "appends if the referenced element is last "
          "item of the parse tree", () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        final anotherElement = bs.title;
        final someNameRefElement = bs.find('a', attrs: {'href': 'unknown'});
        expect(bs4, isNotNull);
        expect(anotherElement, isNotNull);
        expect(someNameRefElement, isNotNull);
        expect(bs4!.string, startsWith('Once upon a time'));
        expect(anotherElement!.string, equals("The Dormouse's story"));
        expect(someNameRefElement!.string, equals("Some name"));

        expect(bs4.children.first.name, 'a');
        expect(bs4.children.length, 4);

        bs4.insertAfter(anotherElement, someNameRefElement);
        expect(bs4.children.last.name, 'title');
        expect(bs4.children.length, 5);
        expect(
          bs4.children.map((e) => e.name),
          equals(<String>['a', 'a', 'a', 'a', 'title']),
        );
      });

      test(
          "throws RangeError if referenced element does not "
          "exist in the parse tree", () {
        final bs4 = bs.find('p', attrs: {'class': 'story'});
        final anotherElement = bs.title;
        final refElement = bs.p;
        expect(bs4, isNotNull);
        expect(anotherElement, isNotNull);
        expect(refElement, isNotNull);

        expect(
          () => bs4!.insertAfter(anotherElement!, refElement),
          throwsRangeError,
        );
      });
    });

    group('extract', () {
      test('removes and returns replaced element from the parse tree', () {
        final bs4 = bs.body;
        expect(bs4, isNotNull);

        expect(bs4!.children.length, 3);

        // remove the second element "p"
        final extracted = bs.find('p', attrs: {'class': 'story'})!.extract();
        expect(extracted.name, equals('p'));
        expect(extracted.className, equals('story'));
        expect(extracted.string, startsWith('Once upon a time there'));
        expect(extracted.children.length, 4);

        // children have one element less
        expect(bs4.children.length, 2);
        expect(
          bs4.children.map((e) => e.name),
          equals(<String>['p', 'p']),
        );
      });
    });

    group('replaceWith', () {
      test(
          'removes and replaces element from the parse tree and '
          'returns it', () {
        final bs4 = bs.body;
        final replacement = bs.title;
        expect(bs4, isNotNull);
        expect(replacement, isNotNull);

        expect(bs4!.children.length, 3);

        // replace the second element "p"
        final replaced = bs4.children[1].replaceWith(replacement!);
        expect(replaced.name, equals('p'));
        expect(replaced.className, equals('story'));
        expect(replaced.string, startsWith('Once upon a time there'));
        expect(replaced.children.length, 4);

        // children have one element less
        expect(bs4.children.length, 3);
        expect(
          bs4.children.map((e) => e.name),
          equals(<String>['p', 'title', 'p']),
        );
      });
    });

    group('operator []=, for attribute value setter', () {
      test('assigns a value to an existing attribute', () {
        final bs4 = bs.body?.a;
        expect(bs4, isNotNull);

        expect(bs4!['href'], isNotNull);
        bs4['href'] = 'new-web.com';
        expect(bs4['href'], equals('new-web.com'));
      });

      test('creates a new attribute with that value if attr was not found', () {
        final bs4 = bs.body?.a;
        expect(bs4, isNotNull);

        expect(bs4!['style'], isNull);
        bs4['style'] = 'some-styles';
        expect(bs4['style'], equals('some-styles'));
      });
    });

    group('set tag name', () {
      test('changes tag name', () {
        bs = BeautifulSoup.fragment('<b class="boldest">Extremely bold</b>');

        final bs4 = bs.findFirstAny();
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('b'));
        expect(
          bs4.toString(),
          equals('<b class="boldest">Extremely bold</b>'),
        );

        // change tag name
        bs4.name = 'blockquote';
        expect(bs4.name, equals('blockquote'));
        expect(
          bs4.toString(),
          equals('<blockquote class="boldest">Extremely bold</blockquote>'),
        );

        // null "nulls" tag name
        bs4.name = null;
        expect(bs4.name, isNull);
        expect(
          bs4.toString(),
          equals('<null class="boldest">Extremely bold</null>'),
        );
      });
    });
  });
}
