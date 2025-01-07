import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/types/activity.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class AwardDetails extends StatelessWidget {
  AwardDetails({super.key});
  final int id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final ActivityController activityController = Get.find();
    Activity activity = activityController.getAward(id);
    final TextEditingController scoreController = TextEditingController();
    final TextEditingController commentController = TextEditingController();
    scoreController.text = activity.score.toString();

    return Scaffold(
      appBar: const TDNavBar(
        height: 48,
        titleFontWeight: FontWeight.w600,
        title: "奖励兑换",
        screenAdaptation: false,
        useDefaultBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '奖励: ${activity.name}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text('描述: ${activity.content}'),
            const SizedBox(height: 16),
            TextField(
              controller: scoreController,
              decoration: const InputDecoration(
                labelText: 'Score',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                labelText: 'Comment',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final score = int.tryParse(scoreController.text);
                final comment = commentController.text;
                if (score != null) {
                  await activityController.createStudentActivity(
                      id, score, comment);
                  Get.back();
                } else {
                  Get.snackbar('错误', '请输入正确的分数');
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.redAccent),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  '确认兑换',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
