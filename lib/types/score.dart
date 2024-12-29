class Score {
  final int total;

  Score({
    required this.total,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(total: json['total'] as int);
  }
}
