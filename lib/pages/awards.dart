import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
import 'package:habit_trail_flutter/types/activity.dart';

class AwardsPage extends StatelessWidget {
  const AwardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivityController activityController = Get.find();
    List<Activity> awardList = activityController.awardList;
    return Obx(
      () => Center(
        child: ListView.separated(
          itemCount: awardList.length,
          itemBuilder: (context, index) {
            final activity = awardList[index];
            return ListTile(
              leading: const Icon(Icons.auto_awesome_rounded),
              title: Text(activity.name),
              subtitle: Text(activity.content),
              onTap: () =>
                  {Get.toNamed('/awardDetails', arguments: activity.id)},
              // trailing: const Icon(Icons.more_horiz),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
