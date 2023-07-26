import 'dart:math';

import 'package:uwurandom/src/model/uwurandom_type.dart';

import 'generate_nonsense.dart' as nonsense;

class CatGirlNonSense {
  const CatGirlNonSense();

  /// Generate a random string like: `mrrrrppurrow`
  String generate([int length = 256, Random? random]) {
    return nonsense.generate(UwURandomType.catgirlnonsense, length, random);
  }
}

const catGirlNonSense = CatGirlNonSense();
