import 'dart:math';

import 'package:uwurandom/src/generate_nonsense.dart';

class NonSense {
  const NonSense();

  String generate([int length = 256, Random? random]) {
    random ??= Random();
    final result = StringBuffer();
    int? prevOp;
    while (result.length < length) {
      final (preOp, res) = generateMore(prevOp, length - result.length, random);
      prevOp = preOp;
      result.write('$res ');
    }

    return result.toString();
  }
}

const nonSense = NonSense();
