class Activity {
  final int id;
  final String name;
  final String content;
  final int score;

  Activity({
    required this.id,
    required this.name,
    required this.content,
    required this.score,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as int,
      name: json['name'] as String,
      content: json['content'] as String,
      score: json['score'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'content': content,
      'score': score,
    };
  }

  static List<Activity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Activity.fromJson(json)).toList();
  }
}
