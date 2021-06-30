import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  late BeautifulSoup bs;

  setUp(() {
    bs = BeautifulSoup(html_doc);
  });

  group('Tags', () {
    group('html tags', () {
      test('finds html tags', () {
        var bs4 = bs.html;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('html'));

        bs4 = bs4.head;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('head'));

        bs4 = bs.title;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('title'));

        bs4 = bs4.parent?.nextSibling;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('body'));
      });
    });
  });
}
