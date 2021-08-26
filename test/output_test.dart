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

      test('returns text, unstripped', () {
        final bs4Text = bs.find('p', class_: 'story')?.getText();
        expect(
          bs4Text,
          startsWith('Once upon a time there were three little sister'),
        );
        expect(
          bs4Text,
          contains('         Elsie'),
        );
      });

      test('returns text, stripped', () {
        final bs4Text = bs.find('p', class_: 'story')?.getText(strip: true);
        expect(
          bs4Text,
          startsWith(
              'Once upon a time there were three little sisters; and their names wereElsie,LacieandTillie'),
        );
      });

      test('returns text, stripped with separator', () {
        final bs4Text =
            bs.find('p', class_: 'story')?.getText(separator: ' ', strip: true);
        expect(
          bs4Text,
          startsWith(
              'Once upon a time there were three little sisters; and their names were Elsie , Lacie and Tillie'),
        );
      });

      test('nested getText, fragment example', () {
        bs = BeautifulSoup.fragment(
            '<a href="http://example.com/">\nI linked to <i>example.com</i>\n</a>');
        final bs4TextNoParams = bs.getText();
        expect(
          bs4TextNoParams,
          equals('\nI linked to example.com\n'),
        );

        final bs4TextSeparator = bs.getText(separator: '|');
        expect(
          bs4TextSeparator,
          equals('\nI linked to |example.com|\n'),
        );

        final bs4TextSeparatorStrip = bs.getText(separator: '|', strip: true);
        expect(
          bs4TextSeparatorStrip,
          equals('I linked to|example.com'),
        );
      });
    });

    group('text', () {
      test('returns text from Bs4Element instance', () {
        var bs4 = bs.p?.find('b');
        expect(bs4?.text, equals("The Dormouse's story"));

        // should be also same with bs4element.string
        bs4 = bs.p?.find('b');
        expect(bs4?.string, equals("The Dormouse's story"));
      });
    });

    group('prettify', () {
      test('prettifies, example #1', () {
        bs = BeautifulSoup.fragment(
            '<b><!--Hey, buddy. Want to buy a used parser?--></b>');

        expect(
          bs.prettify(),
          _trimLeadingWhitespace(
            '''
          <b>
           <!--Hey, buddy. Want to buy a used parser?-->
          </b>''',
          ),
        );
        expect(
          bs.prettify(),
          '<b>\n <!--Hey, buddy. Want to buy a used parser?-->\n</b>',
        );
      });

      test('prettifies, example #2', () {
        bs = BeautifulSoup.fragment('<a><b>text1</b><c>text2</c></b></a>');

        expect(
          bs.prettify(),
          _trimLeadingWhitespace(
            '''
          <a>
           <b>
            text1
           </b>
           <c>
            text2
           </c>
          </a>''',
          ),
        );
        expect(
          bs.prettify(),
          '<a>\n <b>\n  text1\n </b>\n <c>\n  text2\n </c>\n</a>',
        );
      });
    });
  });
}

// credits @Irhn: https://github.com/dart-lang/language/issues/559#issuecomment-528812035
String _trimLeadingWhitespace(String text) {
  final _commonLeadingWhitespaceRE =
      RegExp(r"([ \t]+)(?![^]*^(?!\1))", multiLine: true);
  var commonWhitespace = _commonLeadingWhitespaceRE.matchAsPrefix(text);
  if (commonWhitespace != null) {
    return text.replaceAll(
        RegExp("^${commonWhitespace[1]}", multiLine: true), "");
  }
  return text;
}
