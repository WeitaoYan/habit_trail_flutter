class ScoreDetails {
  final String activityName;
  final int earnedScore;
  final String time;

  ScoreDetails({
    required this.activityName,
    required this.earnedScore,
    required this.time,
  });

  factory ScoreDetails.fromJson(Map<String, dynamic> json) {
    return ScoreDetails(
      activityName: json['activity_name'],
      earnedScore: json['earned_score'] as int,
      time: json['time'],
    );
  }

  static List<ScoreDetails> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ScoreDetails.fromJson(item)).toList();
  }
}
