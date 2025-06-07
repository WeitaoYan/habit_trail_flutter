import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/types/student_activity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../controllers/score_controller.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScoreController scoreController = Get.find();
    return Center(
      child: Column(
        children: [
          Obx(
            () => Text(
              "总积分：${scoreController.score.value.total}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 26,
                color: Colors.blueAccent,
              ),
            ),
          ),
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
                    return TDCell(
                      arrow: false,
                      title: activity.activity,
                      description:
                          '${activity.time.month.toString().padLeft(2, '0')}-${activity.time.day.toString().padLeft(2, '0')} '
                          '${activity.time.hour.toString().padLeft(2, '0')}:${activity.time.minute.toString().padLeft(2, '0')}',
                      note: activity.score.toString(),
                      onLongPress: (TDCell cell) {
                        // 弹出确认对话框询问是否删除
                        showGeneralDialog(
                          context: context,
                          pageBuilder: (BuildContext buildContext,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return TDConfirmDialog(
                              title: activity.comment,
                              action: () {},
                            );
                          },
                        );
                      },
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
