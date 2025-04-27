import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/types/activity.dart';

class TaskDetails extends StatelessWidget {
  TaskDetails({super.key});
  final int id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final ActivityController activityController = Get.find();
    Activity activity = activityController.getTask(id);
    final TextEditingController scoreController = TextEditingController();
    final TextEditingController commentController = TextEditingController();
    scoreController.text = activity.score.toString();

    return Scaffold(
      appBar: const TDNavBar(
        height: 48,
        titleFontWeight: FontWeight.w600,
        title: "任务标记",
        screenAdaptation: true,
        useDefaultBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '任务: ${activity.name}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text('描述: ${activity.content}'),
            const SizedBox(height: 16),
            TDInput(
              inputType: TextInputType.number,
              leftLabel: '分数',
              controller: scoreController,
              hintText: '请输入分数',
              rightBtn: Icon(
                TDIcons.error_circle_filled,
                color: TDTheme.of(context).fontGyColor3,
              ),
            ),
            const SizedBox(height: 16),
            TDInput(
              leftLabel: '备注',
              controller: commentController,
              hintText: '备注些文字',
            ),
            const SizedBox(height: 16),
            TDButton(
              text: '提交任务',
              theme: TDButtonTheme.primary,
              isBlock: true,
              onTap: () async {
                final score = int.tryParse(scoreController.text);
                final comment = commentController.text;
                if (score != null) {
                  await activityController.createStudentActivity(
                      id, score, comment);
                  Get.back();
                } else {
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (BuildContext buildContext,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return const TDConfirmDialog(
                        title: "分数不能为空",
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
