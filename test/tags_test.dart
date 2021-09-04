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
      test('finds html, head, title and body tags', () {
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

      test('finds a and i tags', () {
        bs = BeautifulSoup.fragment(
          '<a href="http://example.com/">I linked to <i>example.com</i></a>',
        );
        var bs4 = bs.html;
        expect(bs4, isNull);

        bs4 = bs.a;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('a'));

        bs4 = bs4.i;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('i'));

        bs4 = bs.a!.i;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('i'));
      });

      test('finds p and b tags', () {
        bs = BeautifulSoup.fragment(
          '<div><p><b>I wish I was bold.</b></p></div>',
        );
        var bs4 = bs.html;
        expect(bs4, isNull);

        bs4 = bs.p;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('p'));

        bs4 = bs4.b;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('b'));

        bs4 = bs4.p;
        expect(bs4, isNull);
      });

      test('finds h1 - h6 tags', () {
        bs = BeautifulSoup(
          '''
        <html>
          <head>
            <title>Title of the document</title>
          </head>
          <body>
            <h1>First-level heading</h1>
            <h2>Second-level heading</h2>
            <h3>Third-level heading</h3>
            <h4>Fourth-level heading</h4>
            <h5>Fifth-level heading</h5>
            <h6>Sixth-level heading</h6>
          </body>
        </html>
          ''',
        );
        expect(bs.html, isNotNull);

        var body = bs.body;
        expect(body, isNotNull);
        expect(body!.name, equals('body'));

        final h1 = body.h1;
        final h2 = body.h2;
        final h3 = body.h3;
        final h4 = body.h4;
        final h5 = body.h5;
        final h6 = body.h6;
        expect(
          <Bs4Element?>[h1, h2, h3, h4, h5, h6].every((e) => e != null),
          isTrue,
        );
        expect(
          <Bs4Element>[h1!, h2!, h3!, h4!, h5!, h6!].map((e) => e.name),
          equals(<String>['h1', 'h2', 'h3', 'h4', 'h5', 'h6']),
        );
      });

      test('finds img and a tags', () {
        bs = BeautifulSoup.fragment(
          '''
          <a href="default.asp">
            <img src="smiley.gif" alt="HTML tutorial" style="width:42px;height:42px;">
          </a>
          ''',
        );
        var bs4 = bs.a;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('a'));

        bs4 = bs.a!.img;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('img'));
        expect(
          bs4.toString(),
          '<img src="smiley.gif" alt="HTML tutorial" style="width:42px;height:42px;">',
        );
      });

      test('finds table tags', () {
        bs = BeautifulSoup.fragment(
          '''
          <table>
            <tr>
              <th>Company</th>
              <th>Contact</th>
              <th>Country</th>
            </tr>
            <tr>
              <td>Alfreds Futterkiste</td>
              <td>Maria Anders</td>
              <td>Germany</td>
            </tr>
            <tr>
              <td>Centro comercial Moctezuma</td>
              <td>Francisco Chang</td>
              <td>Mexico</td>
            </tr>
          </table>
          ''',
        );
        final bs4 = bs.table;
        expect(bs4, isNotNull);
        expect(bs4!.name, equals('table'));
        expect(bs4.findAll('tr').length, 3);
      });

      test('finds lists related tags', () {
        bs = BeautifulSoup.fragment(
          '''
          <div>
            <ul>
              <li>Coffee</li>
              <li>Tea</li>
              <li>Milk</li>
            </ul>
            <ol>
              <li>Coffee</li>
              <li>Tea</li>
              <li>Milk</li>
            </ol>
            <dl>
              <dt>Coffee</dt>
              <dd>- black hot drink</dd>
              <dt>Milk</dt>
              <dd>- white cold drink</dd>
            </dl>
          </div>
          ''',
        );
        final bs4 = bs.findFirstAny();
        expect(bs4, isNotNull);
        expect(bs4!.children.length, 3);
        expect(
          bs4.children.map((e) => e.name),
          equals(<String>['ul', 'ol', 'dl']),
        );

        expect(bs.ul!.children.length, 3);
        expect(bs.ol!.children.length, 3);
        expect(bs.dl!.children.length, 4);
      });
    });
  });
}
