import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:habit_trail_flutter/controllers/student_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return TDCellGroup(
      title: "我的",
      cells: [
        TDCell(
          leftIcon: Icons.person_add,
          title: "创建学生",
          onClick: (TDCell cell) {
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
                    action: () {
                      StudentController studentController = Get.find();
                      studentController
                          .createStudent(textEditingController.text);
                    },
                  ),
                );
              },
            );
          },
        ),
        TDCell(
          leftIcon: Icons.task,
          title: "创建任务",
          onClick: (TDCell cell) {
            Get.toNamed('/createTask');
          },
        ),
        TDCell(
          leftIcon: Icons.auto_awesome_rounded,
          title: "创建奖品",
          onClick: (TDCell cell) {
            Get.toNamed('/createAward');
          },
        ),
        TDCell(
          leftIcon: Icons.switch_account,
          title: "切换学生",
          onClick: (TDCell cell) {
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
}
