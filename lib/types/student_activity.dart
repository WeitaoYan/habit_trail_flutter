// {"student":1,"activity":1,"comment":"","earned_score":10}

class StudentActivity {
  final String activity;
  final String time;
  final String comment;
  final int score;

  StudentActivity({
    required this.activity,
    required this.time,
    required this.comment,
    required this.score,
  });

  factory StudentActivity.fromJson(Map<String, dynamic> json) {
    return StudentActivity(
      time: json['time'],
      activity: json['activity'],
      comment: json['comment'],
      score: json['earned_score'] as int,
    );
  }
  static List<StudentActivity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => StudentActivity.fromJson(item)).toList();
  }
}
