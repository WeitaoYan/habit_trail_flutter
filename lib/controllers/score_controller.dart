import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/student_controller.dart';

import 'package:habit_trail_flutter/types/score.dart';
import 'package:habit_trail_flutter/types/student_activity.dart';

import '../utils/http.dart';

class ScoreController extends GetxController {
  StudentController studentController = Get.find();
  late Rx<Score> score = Score(total: 0).obs;
  late RxList<StudentActivity> studentActivityList = <StudentActivity>[].obs;

  Future fetchScore() async {
    HttpClient client = HttpClient();
    String url = 'students/${studentController.currentId}/totalScore/';
    final response = await client.get(url);
    if (response == null) {
      return;
    }
    score.value = Score.fromJson(response);
  }

  Future fetchDetails() async {
    HttpClient client = HttpClient();
    String url = 'studentActivities/?student=${studentController.currentId}';
    final response = await client.get(url);
    if (response == null) {
      return;
    }
    List<StudentActivity> dataList = StudentActivity.fromJsonList(response);
    studentActivityList.clear();
    studentActivityList.addAll(dataList);
  }

  Future fetchAll() async {
    await fetchScore();
    await fetchDetails();
  }
}
