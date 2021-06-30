import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:test/test.dart';

import 'fixtures/fixtures.dart';

void main() {
  late BeautifulSoup bs;

  setUp(() {
    bs = BeautifulSoup(html_doc);
  });

  group('Output', () {
    group('toString', () {
      test('returns html content from BeautifulSoup instance', () {
        final html = bs.toString();
        expect(html, startsWith('<html>'));
        expect(html.substring(0, 50), contains("The Dormouse's story"));
        expect(html, endsWith('</html>'));
      });

      test('returns html content from Bs4Element instance', () {
        final bs4 = bs.p;
        expect(
          bs4.toString(),
          "<p class=\"title\"><b>The Dormouse's story</b></p>",
        );
      });
    });

    group('getText', () {
      test('returns text from BeautifulSoup instance', () {
        final str = bs.getText();
        expect(str, contains("Once upon a time there"));
        expect(str, contains("and they lived at the bottom"));
        expect(str, contains("Some name"));
        expect(str, contains("..."));

        // should be also same with bs4element.string
        final strEl = bs.findFirstAny()?.string;
        expect(strEl, contains("Once upon a time there"));
        expect(strEl, contains("and they lived at the bottom"));
        expect(strEl, contains("Some name"));
        expect(strEl, contains("..."));
      });

      test('returns text from Bs4Element instance', () {
        var bs4 = bs.p?.find('b');
        expect(bs4?.getText(), equals("The Dormouse's story"));

        // should be also same with bs4element.string
        bs4 = bs.p?.find('b');
        expect(bs4?.string, equals("The Dormouse's story"));
      });
    });
  });
}
