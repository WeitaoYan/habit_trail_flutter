class Student {
  final int id;
  final String name;

  Student({
    required this.id,
    required this.name,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  static List<Student> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Student.fromJson(item)).toList();
  }
}
