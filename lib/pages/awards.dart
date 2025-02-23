import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/types/activity.dart';

class AwardsPage extends StatelessWidget {
  const AwardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivityController activityController = Get.find();
    List<Activity> awardList = activityController.awardList;
    return Obx(
      () => TDCellGroup(
        cells: awardList.map((activity) {
          return TDCell(
            imageWidget: const Icon(TDIcons.cardmembership),
            title: activity.name,
            arrow: true,
            description: activity.content.length > 20
                ? '${activity.content.substring(0, 20)}...'
                : activity.content,
            onClick: (cell) {
              Get.toNamed(
                '/awardDetails',
                arguments: activity.id,
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
