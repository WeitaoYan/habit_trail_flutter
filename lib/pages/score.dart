import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/types/student_activity.dart';

import '../controllers/score_controller.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScoreController scoreController = Get.find();
    return Center(
      child: Column(
        children: [
          Obx(() => Text("总积分：${scoreController.score.value.total}")),
          Expanded(
            child: Obx(() {
              if (scoreController.studentActivityList.isEmpty) {
                return const Center(child: Text('没有记录'));
              } else {
                return ListView.builder(
                  itemCount: scoreController.studentActivityList.length,
                  itemBuilder: (context, index) {
                    StudentActivity activity =
                        scoreController.studentActivityList[index];
                    return ListTile(
                      dense: true,
                      title: Text(activity.activity),
                      subtitle: Text(activity.time),
                      trailing: Text('Score: ${activity.score}'),
                    );
                  },
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
