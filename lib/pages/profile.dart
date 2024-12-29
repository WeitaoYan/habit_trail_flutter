import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_trail_flutter/controllers/activity_controller.dart';
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
          onTap: createStudentHandler,
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
          onTap: switchStudentHandler,
        ),
      ],
    );
  }

  void switchStudentHandler() async {
    StudentController studentController = Get.find();
    Get.defaultDialog(
      title: "切换学生",
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      radius: 6,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var student in studentController.studentList)
            ListTile(
              title: Text(student.name),
              trailing: Icon(Icons.star,
                  color: studentController.currentId.value == student.id
                      ? Colors.blue
                      : Colors.grey),
              onTap: () {
                studentController.currentId.value = student.id;
                Get.back();
              },
            ),
        ],
      ),
    );
  }

  void createStudentHandler() {
    StudentController studentController = Get.find();
    final TextEditingController nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Get.defaultDialog(
      title: "创建学生",
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      radius: 6,
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '姓名',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '姓名不能为空';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              studentController.createStudent(nameController.text);
              Get.back();
            }
          },
          child: const Text('确定'),
        ),
      ],
    );
  }

  void createTaskHandler() {
    ActivityController activityController = Get.find();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final TextEditingController scoreController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Get.defaultDialog(
      title: "创建任务",
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      radius: 6,
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '名称',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '名称不能为空';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: '描述',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '描述不能为空';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: scoreController,
              decoration: const InputDecoration(
                labelText: '分数',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '分数不能为空';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              String name = nameController.text;
              int score = int.parse(scoreController.text);
              String content = contentController.text;
              await activityController.createActivity(name, score, content);
              Get.back();
            }
          },
          child: const Text('确定'),
        ),
      ],
    );
  }

  void createAwardTaskHandler() {
    ActivityController activityController = Get.find();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final TextEditingController scoreController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Get.defaultDialog(
      title: "创建奖品",
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      radius: 6,
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '名称',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '名称不能为空';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: '描述',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '描述不能为空';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: scoreController,
              decoration: const InputDecoration(
                labelText: '分数',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '分数不能为空';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              String name = nameController.text;
              int score = 0 - int.parse(scoreController.text);
              String content = contentController.text;
              await activityController.createActivity(name, score, content);
              Get.back();
            }
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}
