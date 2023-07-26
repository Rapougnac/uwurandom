import 'dart:math';

import 'package:test/test.dart';
import 'package:uwurandom/uwurandom.dart';

void main() {
  test('CatgirlNonsense', () {
    return expect(
      catGirlNonSense.generate(25, Random(1)),
      equals('mrrrrppurrowmewmewmreownyan'),
    );
  });

  test('Keysmash', () {
    return expect(
      keySmash.generate(25, Random(1)),
      equals('kfajkdgahgfhdfhafg;hdhhh;a'),
    );
  });

  test('Scrunkly', () {
    return expect(
      scrunkly.generate(25, Random(1)),
      equals('aww ittle.. aw whenpsy then'),
    );
  });

  test('Nonsense', () {
    return expect(
      nonSense.generate(150, Random(1)),
      equals(
        'khgkfgajhgahgafg;hdhhh;ajgahhfghhgfgfghfgbhkl;hjhflagajkaurhgafgbkafdg'
        'kflkhrhglkskdbkjfghghrhdfgaldskahal;ksdhjhn *twitches ears slightly* '
        'mrwmrowmewnya ',
      ),
    );
  });
}
