import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:habit_trail_flutter/controllers/student_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person_add),
          title: const Text("创建学生"),
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder: (BuildContext buildContext,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                TextEditingController textEditingController =
                    TextEditingController();
                return TDInputDialog(
                  textEditingController: textEditingController,
                  title: "请输入学生姓名",
                  rightBtn: TDDialogButtonOptions(
                    title: "创建",
                    action: () {},
                  ),
                );
              },
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.task),
          title: const Text("创建任务"),
          onTap: createTaskHandler,
        ),
        ListTile(
          leading: const Icon(Icons.auto_awesome_rounded),
          title: const Text("创建奖品"),
          onTap: createAwardTaskHandler,
        ),
        ListTile(
          leading: const Icon(Icons.switch_account),
          title: const Text("切换学生"),
          onTap: () {
            switchStudentHandler(context);
          },
        ),
      ],
    );
  }

  void switchStudentHandler(context) async {
    StudentController studentController = Get.find();
    TDPicker.showMultiPicker(context, title: '切换学生', onConfirm: (selected) {
      studentController.currentId.value = selected[0];
      Navigator.of(context).pop();
    }, data: [
      studentController.studentList.map((e) => e.name).toList(),
    ]);
  }

  void createTaskHandler() {
    Get.toNamed('/createTask');
  }

  void createAwardTaskHandler() {
    Get.toNamed('/createAward');
  }
}
