import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  late BeautifulSoup bs;

  setUp(() {
    bs = BeautifulSoup(html_doc);
  });

  group('TreeSearcher', () {
    group('findAll', () {
      test('finds all with the given tag', () {
        final elements = bs.findAll('a');

        expect(elements.length, 4);
        expect(elements.every((e) => e.name == 'a'), isTrue);
        expect(elements.last.toString(), '<a href="unknown">Some name</a>');
        expect(elements.last.outerHtml, '<a href="unknown">Some name</a>');
      });

      test('finds all with the given tag and specified attributes', () {
        final elements = bs.findAll(
          'a',
          attrs: {'id': 'link1', 'href': 'http://example.com/elsie'},
        );

        expect(elements.length, 1);
        expect(
          elements[0].toString(),
          '<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>',
        );
        expect(
          elements[0].outerHtml,
          '<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>',
        );
      });

      test(
          'does not find if element with specified attributes '
          'does not exists', () {
        final elements =
            bs.findAll('a', attrs: {'id': 'link1', 'href': 'unknown'});

        expect(elements.length, 0);
      });

      test('finds all with any href tag', () {
        final elements = bs.findAll('a', attrs: {'href': true});

        expect(elements.length, 3);
        expect(elements.last.outerHtml, '<a href="unknown">Some name</a>');
      });

      test('finds all when iterated by tags', () {
        final elements = bs.body?.findAll('a');

        expect(elements, isNotNull);
        expect(elements!.length, 4);
        expect(elements.last.outerHtml, '<a href="unknown">Some name</a>');
      });

      test('finds all when using customSelector', () {
        var elements = bs.findAll('', customSelector: '.sister');

        expect(elements.length, 3);
        expect(
          elements.last.toString(),
          '<a class="sister" id="link3">Tillie</a>',
        );

        // specifying attributes does not have influence
        elements = bs.findAll(
          '',
          customSelector: '.sister',
          attrs: {'class': 'top'},
        );
        expect(elements.length, 3);
        expect(
          elements.last.toString(),
          '<a class="sister" id="link3">Tillie</a>',
        );
      });
    });

    group('find', () {
      test('finds with the given tag', () {
        final element = bs.find('a');

        expect(element, isNotNull);
        expect(element!.name, 'a');
        expect(element.className, 'sister');
        expect(element.id, 'link1');
      });

      test('finds with the given tag and specified attributes', () {
        final element = bs.find(
          'a',
          attrs: {'id': 'link1', 'href': 'http://example.com/elsie'},
        );

        expect(element, isNotNull);
        expect(
          element.toString(),
          '<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>',
        );
        expect(
          element!.outerHtml,
          '<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>',
        );
      });

      test(
          'does not find if element with specified attributes '
          'does not exists', () {
        final element = bs.find(
          'a',
          attrs: {'id': 'link1', 'href': 'unknown'},
        );
        expect(element, isNull);
      });

      test(
          'finds first element in the parse tree with the given tag if '
          'the attribute has multiple elements', () {
        final element = bs.find('p', attrs: {'class': 'story'});

        expect(element, isNotNull);
        expect(element!.string, startsWith('Once upon a time'));
      });

      test('finds when iterated by elements', () {
        final element = bs.body?.p?.find('b');

        expect(element, isNotNull);
        expect(element!.name, equals("b"));
        expect(element.string, equals("The Dormouse's story"));
        expect(element.getText(), equals("The Dormouse's story"));
        expect(element.toString(), equals("<b>The Dormouse's story</b>"));
        expect(element.outerHtml, equals("<b>The Dormouse's story</b>"));
      });

      test('finds when using customSelector', () {
        var element = bs.find('', customSelector: '#link1');

        expect(element, isNotNull);
        expect(
          element!.toString(),
          '<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>',
        );

        // specifying attributes does not have influence
        element = bs.find(
          '',
          customSelector: '#link1',
          attrs: {'class': 'top'},
        );
        expect(element, isNotNull);
        expect(
          element!.toString(),
          '<a href="http://example.com/elsie" class="sister" id="link1">Elsie</a>',
        );
      });
    });

    group('findParent', () {
      test('finds with any tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final parent = element!.findParent('*');
        expect(parent!.name, equals('p'));
        expect(parent.children.length, 4);
      });

      test('finds with defined tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final parent = element!.findParent('body');
        expect(parent!.name, equals('body'));
        expect(parent.children.length, 3);
      });

      test('does not find any', () {
        final element = bs.findParent('*');
        expect(element, isNull);
      });
    });

    group('findParents', () {
      test('finds all with any tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final parentElements = element!.findParents('*');
        expect(parentElements.length, 3);
        expect(
          parentElements.map((e) => e.name),
          equals(<String>['p', 'body', 'html']),
        );
      });

      test('finds all with defined tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final parentElements = element!.findParents('body');
        expect(parentElements.length, 1);
        expect(parentElements.map((e) => e.name), equals(<String>['body']));
      });

      test('does not find any', () {
        final elements = bs.findParents('*');
        expect(elements.isEmpty, isTrue);
      });
    });

    group('findNextSibling', () {
      test('finds with any tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final nextSibling =
            element!.findNextSibling('a', attrs: {'id': 'link3'});
        expect(
          nextSibling.toString(),
          equals('<a class="sister" id="link3">Tillie</a>'),
        );

        // any tag name should return same result
        final nextSibling2 =
            element.findNextSibling('a', attrs: {'id': 'link3'});
        expect(
          nextSibling2.toString(),
          equals('<a class="sister" id="link3">Tillie</a>'),
        );
      });

      test('finds with defined tag', () {
        final element = bs.p;
        expect(element, isNotNull);

        final nextSibling = element!.findNextSibling('p');
        expect(nextSibling!.name, equals('p'));
        expect(nextSibling.className, equals('story'));
        expect(nextSibling.children.length, 4);
      });

      test('does not find any', () {
        final element = bs.findNextSibling('*');
        expect(element, isNull);
      });
    });

    group('findNextSiblings', () {
      test('finds all with any tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final nextSiblings = element!.findNextSiblings('*');
        expect(nextSiblings.length, 3);
        expect(
          nextSiblings.map((e) => '${e.name}:${e.id}'),
          equals(<String>['a:link2', 'a:link3', 'a:']),
        );
      });

      test('finds all with defined tag', () {
        final element = bs.head;
        expect(element, isNotNull);

        final nextSiblings = element!.findNextSiblings('body');
        expect(nextSiblings.length, 1);
        expect(nextSiblings.map((e) => e.name), equals(<String>['body']));
      });

      test('does not find from BeautifulSoup instance', () {
        final elements = bs.findNextSiblings('*');
        expect(elements.isEmpty, isTrue);
      });

      test('does not find any', () {
        final element = bs.body;
        expect(element, isNotNull);

        final nextSiblings = element!.findNextSiblings('body');
        expect(nextSiblings.isEmpty, isTrue);
      });
    });

    group('findPreviousSibling', () {
      test('finds with any tag', () {
        final element = bs.body!.findAll('a').last;

        final prevSibling = element.findPreviousSibling('*');
        expect(
          prevSibling!.toString(),
          equals('<a class="sister" id="link3">Tillie</a>'),
        );
      });

      test('finds with defined tag', () {
        bs = BeautifulSoup.fragment(html_comment);
        final element = bs.find('br');
        expect(element, isNotNull);

        final prevSibling = element!.findPreviousSibling('b');
        expect(prevSibling, isNotNull);
        expect(prevSibling!.name, equals('b'));
      });

      test('does not find any', () {
        final element = bs.findPreviousSibling('*');
        expect(element, isNull);
      });
    });

    group('findPreviousSiblings', () {
      test('finds all with any tag', () {
        final element = bs.body;
        expect(element, isNotNull);

        final prevSiblings = element!.findPreviousSiblings('*');
        expect(prevSiblings.length, 1);
        expect(prevSiblings.map((e) => e.name), equals(<String>['head']));
      });

      test('finds all with defined tag', () {
        final element = bs.findAll('a').last;

        final prevSiblings =
            element.findPreviousSiblings('*', attrs: {'href': true});
        expect(prevSiblings.length, 2);
        expect(
          prevSiblings.map((e) => e.id),
          equals(<String>['link2', 'link1']),
        );
      });

      test('finds from BeautifulSoup instance', () {
        final elements = bs.findPreviousSiblings('*');
        expect(elements.isEmpty, isTrue);
      });

      test('does not find any', () {
        final element = bs.head;
        expect(element, isNotNull);

        final prevSiblings = element!.findPreviousSiblings('*');
        expect(prevSiblings.isEmpty, isTrue);
      });
    });

    group('findNextElement', () {
      test('finds with any tag', () {
        final element = bs.p;
        expect(element, isNotNull);

        final nextElement = element!.findNextElement('*');
        expect(nextElement.toString(), equals('<b>The Dormouse\'s story</b>'));
      });

      test('finds with defined tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final nextElement = element!.findNextElement('p');
        expect(nextElement!.toString(), equals('<p class="story">...</p>'));
      });

      test('finds from BeautifulSoup instance', () {
        final element = bs.findNextElement('*');
        expect(element, isNotNull);
        expect(element!.name, equals('head'));
      });

      test('does not find any', () {
        final element = bs.findAll('p').last.findNextElement('*');
        expect(element, isNull);
      });
    });

    group('findAllNextElements', () {
      test('finds all with any tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final nextElements = element!.findAllNextElements('*');
        expect(nextElements.length, 4);
        expect(
          nextElements.map((e) => '${e.name}:${e.id}'),
          equals(<String>['a:link2', 'a:link3', 'a:', 'p:']),
        );
        expect(
          nextElements.last.toString(),
          equals('<p class="story">...</p>'),
        );
      });

      test('finds all with defined tag', () {
        final element = bs.body;
        expect(element, isNotNull);

        final nextElements =
            element!.findAllNextElements('', customSelector: '.story');
        expect(nextElements.length, 2);
        expect(nextElements.map((e) => e.name), equals(<String>['p', 'p']));
        expect(
          nextElements.last.toString(),
          equals('<p class="story">...</p>'),
        );
      });

      test('finds from BeautifulSoup instance', () {
        final elements = bs.findAllNextElements('*');
        expect(elements.length, 11);
        expect(
          elements.map((e) => e.name),
          equals(<String>[
            'head',
            'title',
            'body',
            'p',
            'b',
            'p',
            'a',
            'a',
            'a',
            'a',
            'p',
          ]),
        );
      });

      test('does not find any', () {
        final elements = bs.findAllNextElements('footer');
        expect(elements.length, 0);
      });
    });

    group('findPreviousElement', () {
      test('finds with any tag', () {
        final element = bs.body;
        expect(element, isNotNull);

        final prevElement = element!.findPreviousElement('*');
        expect(prevElement!.name, equals('head'));
      });

      test('finds with defined tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final prevElement = element!.findPreviousElement('p');
        expect(
          prevElement!.toString(),
          startsWith('<p class="story">Once upon a time'),
        );
      });

      test('does not find any', () {
        final element = bs.findPreviousElement('*');
        expect(element, isNull);
      });
    });

    group('findAllPreviousElements', () {
      test('finds all with any tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final prevElements = element!.findAllPreviousElements('*');
        expect(prevElements.length, 5);
        expect(
          prevElements.map((e) => e.name),
          equals(<String>['p', 'p', 'body', 'head', 'html']),
        );
      });

      test('finds all with defined tag', () {
        final element = bs.a;
        expect(element, isNotNull);

        final prevElements = element!.findAllPreviousElements('body');
        expect(prevElements.length, 1);
        expect(prevElements.map((e) => e.name), equals(<String>['body']));
      });

      test('does not find any', () {
        final element = bs.a;
        expect(element, isNotNull);

        final prevElements =
            element!.findAllPreviousElements('body', attrs: {'class': true});
        expect(prevElements.isEmpty, isTrue);
      });

      test('does not find any from BeautifulSoup instance', () {
        final elements = bs.findAllPreviousElements('*');
        expect(elements.isEmpty, isTrue);
      });
    });

    group('findNextParsed', () {
      // test('finds all with any tag', () {
      //   final element = bs.a;
      //   expect(element, isNotNull);
      //
      //   final prevSibling = element!.findParent('*');
      //   expect(prevSibling!.name, equals('p'));
      //   expect(prevSibling.children.length, 4);
      // });

      // test('finds all with defined tag', () {
      //   final element = bs.a;
      //   expect(element, isNotNull);
      //
      //   final prevSibling = element!.findParent('body');
      //   expect(prevSibling!.name, equals('body'));
      //   expect(prevSibling.children.length, 3);
      // });

      // test('finds from BeautifulSoup instance', () {
      //   final element = bs.findParent('*');
      //   expect(element, isNotNull);
      //   expect(element!.name, equals('_'));
      // });

      // test('does not find any', () {
      //   final element = bs.findParent('*');
      //   expect(element, isNull);
      // });
    });

    group('findNextParsedAll', () {
      // test('finds all with any tag', () {
      //   final element = bs.a;
      //   expect(element, isNotNull);
      //
      //   final prevSibling = element!.findParents('*');
      //   expect(prevSibling.length, 3);
      //   expect(
      //     prevSibling.map((e) => e.name),
      //     equals(<String>['p', 'body', 'html']),
      //   );
      // });

      // test('finds all with defined tag', () {
      //   final element = bs.a;
      //   expect(element, isNotNull);
      //
      //   final prevSibling = element!.findParents('body');
      //   expect(prevSibling.length, 1);
      //   expect(prevSibling.map((e) => e.name), equals(<String>['body']));
      // });

      // test('finds from BeautifulSoup instance', () {
      //   final elements = bs.findParents('*');
      //   expect(elements.isEmpty, isTrue);
      // });

      // test('does not find any', () {
      //   final elements = bs.findParents('*');
      //   expect(elements.isEmpty, isTrue);
      // });
    });

    group('findPreviousParsed', () {
      //
    });

    group('findPreviousParsedAll', () {
      //
    });
  });
}
