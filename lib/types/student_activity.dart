class StudentActivity {
  final String activity;
  final DateTime time;
  final String comment;
  final int operator;
  final int score;

  StudentActivity({
    required this.activity,
    required this.time,
    required this.comment,
    required this.operator,
    required this.score,
  });

  factory StudentActivity.fromJson(Map<String, dynamic> json) {
    return StudentActivity(
      time: DateTime.fromMillisecondsSinceEpoch((json['time'] * 1000).toInt()),
      activity: json['activity'],
      comment: json['comment'],
      operator: json['operator'] as int,
      score: json['earned_score'] as int,
    );
  }

  static List<StudentActivity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => StudentActivity.fromJson(item)).toList();
  }
}
