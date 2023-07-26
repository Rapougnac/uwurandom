import 'dart:math';

import 'package:uwurandom/src/model/uwurandom_type.dart';

import 'generate_nonsense.dart' as nonsense;

class KeySmash {
  const KeySmash();

  /// Generate a random string like: `kfajkdgahgf`
  String generate([int length = 256, Random? random]) {
    return nonsense.generate(UwURandomType.keysmash, length, random);
  }
}

const keySmash = KeySmash();
