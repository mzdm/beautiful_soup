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
  });
}
