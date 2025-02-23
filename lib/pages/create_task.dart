// 创建任务页面,页面包含一个表单，标题，任务规则描述，和分数
// 任务规则描述是一个多行文本框，分数是一个数字输入框
// 表单提交后，将任务信息提交到后端
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController ruleController = TextEditingController();
    TextEditingController scoreController = TextEditingController();

    return Scaffold(
      appBar: const TDNavBar(
        height: 48,
        titleFontWeight: FontWeight.w600,
        title: "创建任务",
        screenAdaptation: false,
        useDefaultBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TDInput(
              leftLabel: '任务名称',
              controller: titleController,
              backgroundColor: Colors.white,
              hintText: '请输入任务名称',
            ),
            const SizedBox(
              height: 20,
            ),
            TDInput(
              spacer: TDInputSpacer(iconLabelSpace: 0),
              type: TDInputType.twoLine,
              leftLabel: '规则描述',
              controller: ruleController,
              backgroundColor: Colors.white,
              hintText: '请输入任务规则',
              maxLines: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            TDInput(
              leftLabel: '分数',
              controller: scoreController,
              hintText: '请输入完成时获得分值',
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              height: 32,
            ),
            TDButton(
              text: '确认创建',
              size: TDButtonSize.large,
              type: TDButtonType.fill,
              theme: TDButtonTheme.primary,
              shape: TDButtonShape.filled,
              isBlock: true,
              onTap: () {
                //显示加载中状态
                Get.dialog(
                  const Center(
                    child: TDLoading(
                      size: TDLoadingSize.large,
                      icon: TDLoadingIcon.circle,
                      text: '任务创建中...',
                      textColor: Colors.white,
                      axis: Axis.vertical,
                    ),
                  ),
                  barrierColor: Colors.black.withAlpha(128),
                );
                ActivityController activityController = Get.find();
                activityController.createActivity(
                  titleController.text,
                  int.parse(scoreController.text),
                  ruleController.text,
                );
                // 关闭加载中状态
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
