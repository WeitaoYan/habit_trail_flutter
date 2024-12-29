import 'package:get/get.dart';
import 'package:habit_trail_flutter/types/student.dart';
import '../utils/http.dart';

class StudentController extends GetxController {
  late Rx<int> currentId = 0.obs;
  late RxList<Student> studentList = <Student>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchStudentList();
    await _loadCurrentId();
  }

  Future fetchStudentList() async {
    HttpClient client = HttpClient();
    final response = await client.get('students/');
    if (response == null) {
      return;
    }
    List<Student> studentList = Student.fromJsonList(response);
    this.studentList.clear();
    this.studentList.addAll(studentList);
  }

  Future createStudent(String name) async {
    HttpClient client = HttpClient();
    final response = await client.post('students/', {"name": name});
    Student student = Student.fromJson(response);
    studentList.add(student);
  }

  Future<void> _loadCurrentId() async {
    if (studentList.isNotEmpty) {
      currentId.value = studentList.first.id;
    }
  }
}
