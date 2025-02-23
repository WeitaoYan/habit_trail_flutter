import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/types/activity.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivityController activityController = Get.find();
    RxList<Activity> taskList = activityController.taskList;
    return Obx(
      () => TDCellGroup(
        cells: taskList.map((activity) {
          return TDCell(
            imageWidget: const Icon(TDIcons.calendar_1),
            title: activity.name,
            arrow: true,
            description: activity.content.length > 20
                ? '${activity.content.substring(0, 20)}...'
                : activity.content,
            onClick: (cell) {
              Get.toNamed(
                '/taskDetails',
                arguments: activity.id,
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
