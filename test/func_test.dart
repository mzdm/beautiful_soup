import 'package:beautiful_soup/beautiful_soup.dart';
import 'package:beautiful_soup/src/helpers.dart';
import 'package:html/parser.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  late BeautifulSoup bs;

  setUp(() {
    bs = BeautifulSoup(html_doc);
  });

  group('Extensions', () {
    group('Bs4Element from html.Element', () {
      test('parsing fragment does not add html tag', () {
        final bs4 = parse(html_doc).querySelector('p')?.bs4;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('p'));
      });

      test('parsing html has html tag', () {
        final bs4 = parse(html_doc).querySelector('*')?.bs4;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('html'));
        expect(bs4.children.first.name, equals('head'));
      });
    });
  });

  group('Helpers', () {
    group('recursiveSearch', () {
      test('finds all recursively', () {
        final bs4 = bs.body;
        expect(bs4, isNotNull);

        // body has 3 elements
        expect(bs4!.children.length, 3);

        // recursive search gets also nested, deep ones
        final recursive = recursiveSearch(bs4).toList();
        expect(recursive.length, 9);
      });
    });
  });
}
