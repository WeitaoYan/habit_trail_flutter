import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/types/activity.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivityController activityController = Get.find();
    RxList<Activity> taskList = activityController.taskList;
    return Obx(
      () => Center(
        child: ListView.separated(
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            final activity = taskList[index];
            return ListTile(
              leading: const Icon(Icons.task),
              title: Text(activity.name),
              subtitle: Text(
                activity.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => {
                Get.toNamed(
                  '/taskDetails',
                  arguments: activity.id,
                )
              },
              // trailing: const Icon(Icons.more_horiz),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
