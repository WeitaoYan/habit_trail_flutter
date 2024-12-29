import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/student_controller.dart';
import 'package:habit_trail_flutter/controllers/score_controller.dart';
import 'package:habit_trail_flutter/types/activity.dart';
import 'package:habit_trail_flutter/types/student_activity.dart';
import '../utils/http.dart';

class ActivityController extends GetxController {
  RxList<Activity> taskList = <Activity>[].obs;
  RxList<Activity> awardList = <Activity>[].obs;
  StudentController studentController = Get.find();

  Activity getTask(int id) {
    return taskList.firstWhere((element) => element.id == id);
  }

  Activity getAward(int id) {
    return awardList.firstWhere((element) => element.id == id);
  }

  Future fetchActivityList() async {
    HttpClient client = HttpClient();
    final response = await client.get('activities/');
    if (response == null) {
      if (kDebugMode) {
        print("fetchActivityList 没有拿到有效数据");
      }
      return;
    }
    List<Activity> activityList = Activity.fromJsonList(response);
    for (Activity item in activityList) {
      if (item.score > 0) {
        taskList.add(item);
      } else if (item.score < 0) {
        awardList.add(item);
      }
    }
  }

  Future createActivity(String name, int score, String content) async {
    HttpClient client = HttpClient();
    final response = await client.post('activities/', {
      'name': name,
      'content': content,
      'score': score,
    });
    Activity activityList = Activity.fromJson(response);
    if (activityList.score > 0) {
      taskList.add(activityList);
    } else if (activityList.score < 0) {
      awardList.add(activityList);
    }
  }

  Future createStudentActivity(
      int activityId, int score, String comment) async {
    HttpClient client = HttpClient();
    final response = await client.post('studentActivities/', {
      "student": studentController.currentId.value,
      "activity": activityId,
      "comment": comment,
      "earned_score": score,
    });
    if (response == null) {
      return;
    }
    StudentActivity activity = StudentActivity.fromJson(response);
    ScoreController scoreController = Get.find();
    scoreController.studentActivityList.add(activity);
    scoreController.fetchScore();
  }
}
