import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  late BeautifulSoup bs;

  setUp(() {
    bs = BeautifulSoup(html_doc);
  });

  group('Element', () {
    group('name', () {
      test('finds name by tag', () {
        final bs4 = bs.title;

        expect(bs4, isNotNull);
        expect(bs4!.name, 'title');
      });

      test('finds name by find', () {
        final bs4 = bs.find('title');

        expect(bs4, isNotNull);
        expect(bs4!.name, 'title');
      });
    });

    group('outerHtml', () {
      test('finds outerHtml', () {
        final bs4 = bs.p;

        expect(bs4, isNotNull);
        expect(
          bs4!.outerHtml,
          equals("<p class=\"title\"><b>The Dormouse's story</b></p>"),
        );
      });
    });

    group('innerHtml', () {
      test('finds innerHtml', () {
        final bs4 = bs.p;

        expect(bs4, isNotNull);
        expect(
          bs4!.innerHtml,
          equals("<b>The Dormouse's story</b>"),
        );
      });

      test('does not find innerHtml (empty string)', () {
        bs = BeautifulSoup.fragment(html_placeholder_empty);
        final bs4 = bs.findFirstAny();

        expect(bs4, isNotNull);
        expect(bs4!.innerHtml, equals(''));
      });
    });

    group('className', () {
      test('finds className', () {
        final bs4 = bs.p;

        expect(bs4, isNotNull);
        expect(bs4!.className, 'title');
      });

      test('does not find className (empty string)', () {
        final bs4 = bs.title;

        expect(bs4, isNotNull);
        expect(bs4!.className, '');
      });
    });

    group('id', () {
      test('finds id', () {
        final bs4 = bs.body?.a;

        expect(bs4, isNotNull);
        expect(bs4!.id, 'link1');
      });

      test('does not find id (empty string)', () {
        final bs4 = bs.title;

        expect(bs4, isNotNull);
        expect(bs4!.id, '');
      });
    });

    group('operator [], for attribute value getter', () {
      test('finds attribute value', () {
        final attr = bs.body?.a?['href'];

        expect(attr, isNotNull);
        expect(attr!, equals('http://example.com/elsie'));
      });

      test('does not find attribute value', () {
        final attr = bs.body?.a?['style'];
        expect(attr, isNull);
      });
    });
  });
}
