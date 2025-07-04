import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/student_controller.dart';

import 'package:habit_trail_flutter/types/score.dart';
import 'package:habit_trail_flutter/types/student_activity.dart';
import 'package:habit_trail_flutter/types/response.dart';

import '../utils/http.dart';

class ScoreController extends GetxController {
  StudentController studentController = Get.find();
  int nextPage = 1;
  late int totalCount;
  late Rx<Score> score = Score(total: 0).obs;
  late RxList<StudentActivity> studentActivityList = <StudentActivity>[].obs;

  ScoreController() {
    studentActivityList.listen((_) {
      studentActivityList.sort(
        (a, b) => b.time.compareTo(a.time), // 假设 StudentActivity 有 time 字段
      );
    });
  }

  /// 从网络获取学生总分数
  Future fetchScore() async {
    HttpClient client = HttpClient();
    String url = 'students/${studentController.currentId}/totalScore/';
    final response = await client.get(url);
    if (response == null) {
      return;
    }
    score.value = Score.fromJson(response);
  }

  /// 从网络获取积分列表
  Future fetchDetails() async {
    HttpClient client = HttpClient();
    int student = studentController.currentId.value;
    int page = nextPage;
    String url = 'studentActivities/?student=$student&page=$page';
    final response = await client.get(url);
    if (response == null) {
      return;
    }
    PaginationResponse<StudentActivity> responses =
        PaginationResponse.fromResponseJson(
      response,
      (json) => StudentActivity.fromJson(json),
    );
    totalCount = responses.count;
    for (var element in responses.results) {
      studentActivityList.add(element);
    }
    nextPage++;
  }

  Future fetchInitScore() async {
    await fetchScore();
    await fetchDetails();
  }
}
