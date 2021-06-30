import 'package:beautiful_soup_dart/beautiful_soup.dart';
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
        bs = BeautifulSoup(html_prettify2);
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
        bs = BeautifulSoup(html_prettify2);
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
  });
}
