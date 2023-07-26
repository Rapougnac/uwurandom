import 'dart:math';

import 'package:uwurandom/src/data/catgirlnonsense.dart';
import 'package:uwurandom/src/data/keysmash.dart';
import 'package:uwurandom/src/data/scrunkly.dart';
import 'package:uwurandom/src/model/markov_data.dart';
import 'package:uwurandom/src/model/uwurandom_type.dart';

const numOps = 10;

const actions = [
  '*tilts head*',
  '*twitches ears slightly*',
  '*purrs*',
  '*falls asleep*',
  '*sits on ur keyboard*',
  '*nuzzles*',
  '*stares at u*',
  '*points towards case of monster zero ultra*',
  '*sneezes*',
  '*plays with yarn*',
  '*eats all ur doritos*',
  '*lies down on a random surface*',
];

String generate(UwURandomType type, [int length = 256, Random? random]) {
  random ??= Random();
  final data = switch (type) {
    UwURandomType.catgirlnonsense =>
      catgirlNonsense.map(MarkovData.fromJson).toList(),
    UwURandomType.keysmash => keySmash.map(MarkovData.fromJson).toList(),
    UwURandomType.scrunkly => scrunkly.map(MarkovData.fromJson).toList(),
  };

  final index = switch (type) {
    UwURandomType.catgirlnonsense => 7, // mr
    UwURandomType.scrunkly => 37, // aw
    UwURandomType.keysmash => random.nextInt(data.length)
  };

  return generateMarkov(data, length, index, random);
}

String generateMarkov(
  List<MarkovData> data,
  int numChars,
  int initNgram,
  Random random,
) {
  var result = StringBuffer(data[initNgram].name);
  var ngramIndex = initNgram;
  for (int i = 0; i < numChars; i++) {
    final ngram = data[ngramIndex];
    final rdn = random.nextInt(ngram.totalProbability);
    for (final choice in ngram.choices) {
      if (rdn < choice.cumulativeProbability) {
        ngramIndex = choice.nextNgram;
        result.write(choice.nextChar);
        break;
      }
    }
  }

  return result.toString();
}

(int, String) generateMore(
  int? previousOp,
  int remainingLength,
  Random random,
) {
  int randOp;

  if (previousOp != null) {
    randOp = random.nextInt(numOps - 1);
    if (randOp >= previousOp) {
      randOp++;
    }
  } else {
    randOp = random.nextInt(numOps - 1);
  }

  previousOp = randOp;

  final randomInt150 = random.nextInt(150);

  final res = switch (randOp) {
    0 => 'uwu',
    1 => '${generate(
        UwURandomType.catgirlnonsense,
        min(randomInt150 + 25, remainingLength - 3),
        random,
      )}nya',
    2 => 'ny${'a' * (random.nextInt(8) + 1)}',
    3 => '>${'/' * (random.nextInt(7) + 3)}<',
    4 => ':3',
    5 => actions[random.nextInt(actions.length)],
    6 => generate(
        UwURandomType.keysmash,
        min(randomInt150 + 25, remainingLength),
        random,
      ),
    7 => 'A' * (random.nextInt(17) + 5),
    8 => generate(
        UwURandomType.scrunkly,
        min(random.nextInt(100) + 25, remainingLength),
        random,
      ),
    9 => 'uwu',
    _ => throw Exception('Unhandled op $randOp'),
  };

  return (previousOp, res);
}
