class MarkovData {
  final List<MarkovChoice> choices;
  final int totalProbability;
  final String name;

  const MarkovData({
    required this.choices,
    required this.name,
    required this.totalProbability,
  });

  factory MarkovData.fromJson(Map<String, Object?> json) {
    return MarkovData(
      choices: (json['choices'] as List<Map<String, Object?>>)
          .map(MarkovChoice.fromJson)
          .toList(),
      name: json['name'] as String,
      totalProbability: json['totalProbability'] as int,
    );
  }

  Map<String, Object?> toJson() => {
        'name': name,
        'totalProbability': totalProbability,
        'choices': choices.map((choice) => choice.toJson()).toList(),
      };

  @override
  String toString() => toJson().toString();
}

class MarkovChoice {
  final int nextNgram;
  final String nextChar;
  final int cumulativeProbability;

  const MarkovChoice({
    required this.cumulativeProbability,
    required this.nextChar,
    required this.nextNgram,
  });

  factory MarkovChoice.fromJson(Map<String, Object?> json) {
    return MarkovChoice(
      cumulativeProbability: json['cumulativeProbability'] as int,
      nextChar: json['nextChar'] as String,
      nextNgram: json['nextNgram'] as int,
    );
  }

  Map<String, Object?> toJson() => {
        'nextNgram': nextNgram,
        'nextChar': nextChar,
        'cumulativeProbablility': cumulativeProbability,
      };

  @override
  String toString() => toJson().toString();
}
