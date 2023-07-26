import 'dart:math';

import 'package:uwurandom/src/model/uwurandom_type.dart';

import 'generate_nonsense.dart' as nonsense;

class Scrunkly {
  const Scrunkly();

  /// Generate a random string like: `aww ittle.. `
  String generate([int length = 256, Random? random]) {
    return nonsense.generate(UwURandomType.scrunkly, length, random);
  }
}

const scrunkly = Scrunkly();
