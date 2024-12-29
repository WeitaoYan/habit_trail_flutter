import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
        title: const Text('Task Details'),
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
                backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  '标记完成',
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
