import 'dart:math';

import '../generate_nonsense.dart' as ns;

typedef Spaces = ({double faces, double actions, double stutters});

const uwuifier = Uwuifier();

class Uwuifier {
  static const faces = [
    '(・`ω´・)',
    ';;w;;',
    'owo',
    'UwU',
    '>w<',
    '^w^',
    '(* ^ ω ^)',
    '(⌒ω⌒)',
    'ヽ(*・ω・)ﾉ',
    '(o´∀`o)',
    '(o･ω･o)',
    '＼(＾▽＾)／',
    '(*^ω^)',
    '(◕‿◕✿)',
    '(◕ᴥ◕)',
    'ʕ•ᴥ•ʔ',
    'ʕ￫ᴥ￩ʔ',
    '(*^.^*)',
    '(｡♥‿♥｡)',
    '>^.^<',
    ':3',
    'x3',
  ];

  static const actions = ns.actions;

  static final Map<Pattern, String Function(Match)> replacers = {
    RegExp(r'(?:r|l)'): (_) => 'w',
    RegExp(r'(?:R|L)'): (_) => 'W',
    RegExp(r'n([aeiou])'): (match) => 'ny${match[1]}',
    RegExp(r'N([aeiou])'): (match) => 'Ny${match[1]}',
    RegExp(r'N([AEIOU])'): (match) => 'Ny${match[1]}',
    'ove': (_) => 'uv',
  };

  static const exclamations = ['!?', '?!?1', '?!!', '!!11', '?!?!'];

  final double wordsModifier;

  final Spaces spacesModifier;

  final double exclamationsModifier;

  const Uwuifier({
    this.wordsModifier = 0.9,
    this.spacesModifier = (faces: 0.04, actions: 0.02, stutters: 0.1),
    this.exclamationsModifier = 1,
  });

  String uwuifyWords(String sentence) {
    final words = sentence.split(' ');

    return words.map((word) {
      if (word[0] == '@') {
        return word;
      }

      if (isUri(word)) {
        return word;
      }

      final random = Random();

      for (final MapEntry(key: replacer, value: replacment)
          in replacers.entries) {
        if (random.nextDouble() > wordsModifier) {
          continue;
        }

        word = word.replaceAllMapped(replacer, replacment);
      }

      return word;
    }).join(' ');
  }

  String uwuifySpaces(String sentence) {
    final words = sentence.split(' ');

    final faceThreshold = spacesModifier.faces;
    final actionsThreshold = spacesModifier.actions + faceThreshold;
    final stutterThreshold = spacesModifier.stutters + actionsThreshold;

    return words.indexed.map((entry) {
      var (i, word) = entry;

      final random = Random();
      final nextDouble = random.nextDouble();

      final firstCharater = word[0];

      final isNotEmpty = word.trim().isNotEmpty;

      if (nextDouble <= faceThreshold && isNotEmpty) {
        word += ' ${faces[random.nextInt(faces.length)]}';
      } else if (nextDouble <= actionsThreshold && isNotEmpty) {
        word += ' ${actions[random.nextInt(actions.length)]}';
      } else if (nextDouble <= stutterThreshold && isNotEmpty && !isUri(word)) {
        final stutter = random.nextInt(2);

        return '$firstCharater-' * stutter + word;
      }

      return word;
    }).join(' ');
  }

  String uwuifyExclamations(String sentence) {
    final words = sentence.split(' ');
    final pattern = RegExp(r'[!?]+$');

    return words.map((word) {
      final random = Random();

      if (!pattern.hasMatch(word) ||
          random.nextDouble() > exclamationsModifier ||
          word.trim().isEmpty) {
        return word;
      }

      word = word.replaceAll(pattern, '');
      word += exclamations[random.nextInt(exclamations.length)];

      return word;
    }).join(' ');
  }

  String uwuifySentence(String sentence) {
    sentence = uwuifyWords(sentence);
    sentence = uwuifySpaces(sentence);
    sentence = uwuifyExclamations(sentence);

    return sentence;
  }
}

bool isUri(String word) => Uri.tryParse(word)?.isAbsolute ?? false;
